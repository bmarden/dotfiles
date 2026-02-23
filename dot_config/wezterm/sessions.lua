---@diagnostic disable: assign-type-mismatch
local wezterm = require('wezterm') ---@type Wezterm
local act = wezterm.action
local mux = wezterm.mux

local module = {}

local session_defs = {
  {
    key = 'a',
    name = 'member-dev',
    tabs = {
      {
        cwd = wezterm.home_dir .. '/code/member-backend',
        split = { direction = 'Bottom', size = 0.25 },
      },
      {
        cwd = wezterm.home_dir .. '/code/turnkey-frontend',
        split = { direction = 'Bottom', size = 0.25 },
      },
    },
  },
  {
    key = 'd',
    name = 'dotfiles',
    tabs = {
      { cwd = wezterm.home_dir .. '/.local/share/chezmoi', split = { direction = 'Bottom', size = 0.25 } },
    },
  },
  {
    key = 'o',
    name = 'obsidian',
    tabs = {
      { cwd = wezterm.home_dir .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/ben-brain' },
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

local function setup_tab_splits(tab_obj, tab_def)
  if not tab_def.split then
    return
  end
  local pane = tab_obj:active_pane()
  pane:split({
    direction = tab_def.split.direction,
    size = tab_def.split.size,
    cwd = tab_def.cwd,
  })
  -- Re-focus the top/main pane after splitting
  pane:activate()
end

local function create_workspace(session, window)
  -- Spawn first tab in the new workspace
  local tab, _, mux_window = mux.spawn_window({
    workspace = session.name,
    cwd = session.tabs[1].cwd,
  })
  setup_tab_splits(tab, session.tabs[1])

  -- Spawn remaining tabs
  for i = 2, #session.tabs do
    local new_tab = mux_window:spawn_tab({ cwd = session.tabs[i].cwd })
    setup_tab_splits(new_tab, session.tabs[i])
  end

  -- Focus the first tab
  tab:activate()

  -- Switch the GUI window to the new workspace
  window:perform_action(act.SwitchToWorkspace({ name = session.name }), window:active_pane())
end

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
