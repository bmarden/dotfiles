---@diagnostic disable: assign-type-mismatch
local wezterm = require('wezterm') ---@type Wezterm
local act = wezterm.action

local module = {}

local nvim = '/Users/bmarden/.local/share/bob/nvim-bin/nvim'
local wezterm_bin = '/opt/homebrew/bin/wezterm'

-- nvim sources this on launch to fetch + render + position the scrollback.
local nvim_script = wezterm.config_dir .. '/scrollback_nvim.lua'

local function setup_scrollback_event()
  wezterm.on('trigger-vim-with-scrollback', function(window, pane)
    local dims = pane:get_dimensions()
    local cursor = pane:get_cursor_position()

    window:perform_action(
      act.SpawnCommandInNewTab({
        args = { nvim, '-S', nvim_script },
        set_environment_variables = {
          WEZTERM_SCROLLBACK_BIN = wezterm_bin,
          WEZTERM_SCROLLBACK_PANE = tostring(pane:pane_id()),
          WEZTERM_SCROLLBACK_ROWS = tostring(dims.scrollback_rows),
          WEZTERM_SCROLLBACK_VIEWPORT = tostring(dims.viewport_rows),
          WEZTERM_SCROLLBACK_PHYS_TOP = tostring(dims.physical_top),
          WEZTERM_SCROLLBACK_CURSOR_Y = tostring(cursor.y),
        },
      }),
      pane
    )
  end)
end

function module.apply_to_config(config)
  setup_scrollback_event()

  config.keys = config.keys or {}
  table.insert(config.keys, {
    key = 'i',
    mods = 'CMD|OPT',
    action = act.EmitEvent('trigger-vim-with-scrollback'),
  })
end

return module
