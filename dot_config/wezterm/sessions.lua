---@diagnostic disable: assign-type-mismatch
local wezterm = require('wezterm') ---@type Wezterm
local act = wezterm.action
local mux = wezterm.mux

local module = {}

---@class SessionDefinition
---@field key string The key to bind for this session
---@field name string The name of the workspace/session
---@field tabs PaneNode[] The list of tabs to create in this session; each tab is the root pane node

--- A pane node describes one pane and, optionally, how it splits to create more.
--- The split's `into` is the child node placed in the newly created pane, which
--- may itself split further — allowing arbitrary nested layouts.
---@class PaneNode
---@field cwd? string The working directory for this pane
---@field split? SplitDef Optional split that carves a child pane out of this one

---@class SplitDef
---@field direction 'Left' | 'Right' | 'Top' | 'Bottom' Where the new pane goes relative to the current one
---@field size number Fraction (0-1) of the current pane given to the new pane
---@field into PaneNode The pane node created by this split (may split again)

local home = wezterm.home_dir

---@type SessionDefinition[]
local session_defs = {
  {
    key = 'a',
    name = 'member-dev',
    tabs = {
      -- Recreates the kitty member-dev session: vertical split, main pane ~70%.
      -- The new pane takes 30% on the right.
      {
        cwd = home .. '/code/member-backend',
        split = { direction = 'Bottom', size = 0.3, into = { cwd = home .. '/code/member-backend' } },
      },
      {
        cwd = home .. '/code/turnkey-frontend',
        split = { direction = 'Bottom', size = 0.3, into = { cwd = home .. '/code/turnkey-frontend' } },
      },
      {
        cwd = home .. '/code/member-infra',
        split = { direction = 'Bottom', size = 0.3, into = { cwd = home .. '/code/member-infra' } },
      },
      {
        cwd = home .. '/code/member-frontend',
        split = { direction = 'Bottom', size = 0.3, into = { cwd = home .. '/code/member-frontend' } },
      },
    },
  },
  {
    key = 'd',
    name = 'dotfiles',
    tabs = {
      -- Top pane full width; bottom strip split into two side-by-side panes.
      {
        cwd = home .. '/.local/share/chezmoi',
        split = {
          direction = 'Bottom',
          size = 0.3,
          into = {
            cwd = home .. '/.local/share/chezmoi',
            split = { direction = 'Right', size = 0.5, into = { cwd = home .. '/.config' } },
          },
        },
      },
      {
        cwd = home .. '/code-personal/nvim-plugins/ghpr.nvim',
        split = {
          direction = 'Bottom',
          size = 0.3,
          into = {
            cwd = home .. '/code-personal/nvim-plugins/ghpr.nvim',
          },
        },
      },
    },
  },
  {
    key = 'o',
    name = 'obsidian',
    tabs = {
      { cwd = home .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/ben-brain' },
    },
  },
}

local function workspace_exists(name)
  for _, ws in ipairs(mux.get_workspace_names()) do
    if ws == name then
      return true
    end
  end
  return false
end

--- Recursively realize a pane node's splits starting from an existing pane.
--- The given `pane` already exists (spawned by the tab/window); this only
--- creates the descendant panes described by `node.split`. No pane is
--- activated here — activating mid-build races the GUI focus, so the caller
--- activates the single intended main pane once after the whole tree is built.
---@param pane Pane The pane that corresponds to `node`
---@param node PaneNode The pane node to realize splits for
local function setup_pane(pane, node)
  if not node.split then
    return
  end
  local child_pane = pane:split({
    direction = node.split.direction,
    size = node.split.size,
    cwd = node.split.into.cwd,
  })
  -- Realize any further nesting inside the newly created pane.
  setup_pane(child_pane, node.split.into)
end

--- Builds the pane tree for a tab and returns the tab's main (root) pane.
---@param tab_obj MuxTab The tab object whose root pane should be laid out
---@param node PaneNode The root pane node for this tab
---@return Pane main_pane The tab's top-level pane
local function setup_tab_splits(tab_obj, node)
  local main_pane = tab_obj:active_pane()
  setup_pane(main_pane, node)
  return main_pane
end

-- Create a new workspace and spawn tabs with splits based on the session definition
--- @param session SessionDefinition The session definition containing name, tabs, and split info
--- @param window Window The current WezTerm window object
local function create_workspace(session, window)
  -- Spawn first tab in the new workspace
  local tab, _, mux_window = mux.spawn_window({
    workspace = session.name,
    cwd = session.tabs[1].cwd,
  })
  local main_pane = setup_tab_splits(tab, session.tabs[1])

  -- Spawn remaining tabs
  for i = 2, #session.tabs do
    local new_tab = mux_window:spawn_tab({ cwd = session.tabs[i].cwd })
    setup_tab_splits(new_tab, session.tabs[i])
  end

  -- Focus the first tab and its main pane once, after the whole layout is built.
  tab:activate()
  main_pane:activate()

  -- Switch the GUI to the new workspace. Use SwitchToWorkspace via the existing
  -- window's current pane purely to trigger the GUI swap; the mux activations
  -- above already chose the correct tab/pane inside the new workspace.
  window:perform_action(act.SwitchToWorkspace({ name = session.name }), window:active_pane())
end

---@param session SessionDefinition The session definition containing name, tabs, and split info
local function build_session_action(session)
  return wezterm.action_callback(function(window, pane)
    if workspace_exists(session.name) then
      window:perform_action(act.SwitchToWorkspace({ name = session.name }), pane)
    else
      create_workspace(session, window)
    end
  end)
end

function module.apply_to_config(config)
  config.keys = config.keys or {}

  for _, session in ipairs(session_defs) do
    table.insert(config.keys, {
      key = session.key,
      mods = 'LEADER',
      action = build_session_action(session),
    })
  end

  -- Switch to previous workspace (like kitty ctrl+a>l)
  table.insert(config.keys, {
    key = 'l',
    mods = 'LEADER',
    action = act.SwitchWorkspaceRelative(-1),
  })

  -- Show workspace picker (like kitty ctrl+a>s)
  table.insert(config.keys, {
    key = 's',
    mods = 'LEADER',
    action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
  })
end

return module
