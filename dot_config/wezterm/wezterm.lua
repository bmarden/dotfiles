---@diagnostic disable: assign-type-mismatch
local wezterm = require('wezterm') ---@type Wezterm

local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
local config = wezterm.config_builder() ---@type Config

config.term = 'wezterm'

-- Setup initial window size
config.initial_cols = 200
config.initial_rows = 80

config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

-- config.font = wezterm.font('Monaspace Argon')
config.font = wezterm.font('Dank Mono')
config.font_size = 13

--- ==  :=  || >= !=  =>  <=  &&  |>
config.harfbuzz_features = {
  'calt=1',
  'ss01=1',
  'ss02=1',
  'ss03=1',
  'ss04=1',
  'ss05=1',
  'ss06=1',
  'ss07=1',
  'ss08=1',
  'ss09=1',
  'ss10=1',
  'liga=1',
}

local scheme = wezterm.color.get_builtin_schemes()['Bamboo']
scheme.background = '#111317'
scheme.cursor_bg = '#c0c0c0'
config.color_schemes = {
  ['Bamboo'] = scheme,
}

config.color_scheme = 'Bamboo'

config.max_fps = 144

-- Hide native title bar, keep rounded corners (like kitty titlebar-only)
config.window_decorations = 'RESIZE'

-- Match tab bar background to terminal background
config.window_frame = {
  active_titlebar_bg = '#111317',
  inactive_titlebar_bg = '#111317',
}

local TAB_BAR_BG = '#111317'

wezterm.on('format-tab-title', function(tab, _, _, _, hover, _)
  local background = '#1a1c23'
  local foreground = '#5a5a6a'

  if tab.is_active then
    background = '#2a2d37'
    foreground = '#c0c0c0'
  elseif hover then
    background = '#222530'
    foreground = '#909090'
  end

  -- Get workspace:cwd format (like kitty session_name:last_dir)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  local dir_name = ''
  if cwd then
    local path = cwd.file_path or tostring(cwd)
    dir_name = path:match('([^/]+)/?$') or path
  end

  local workspace = tab.window_title or 'default'
  -- window_title isn't available on tab; use the mux to get workspace name
  local title = dir_name

  -- Prepend workspace name if we can get it from the tab's window
  local mux_tab = wezterm.mux.get_tab(tab.tab_id)
  if mux_tab then
    local mux_window = mux_tab:window()
    if mux_window then
      ---@diagnostic disable-next-line: cast-local-type
      workspace = mux_window:get_workspace()
      title = workspace .. ':' .. dir_name
    end
  end

  -- title = " " .. wezterm.truncate_right(title, max_width - 1) .. " "

  return {
    { Background = { Color = TAB_BAR_BG } },
    { Foreground = { Color = background } },
    -- { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = TAB_BAR_BG } },
    { Foreground = { Color = background } },
    -- { Text = SOLID_RIGHT_ARROW },
  }
end)

local act = wezterm.action

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Terminology is backwards for wezterm, SplitVertical actually creates a horizontal split
  {
    key = 'h',
    mods = 'CMD|OPT',
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  -- Split horizontal (like kitty cmd+opt+h)
  {
    key = 'v',
    mods = 'CMD|OPT',
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  -- Close current pane (like kitty cmd+opt+w)
  {
    key = 'w',
    mods = 'CMD|OPT',
    action = act.CloseCurrentPane({ confirm = true }),
  },
  {
    key = 'Enter',
    mods = 'CMD',
    action = act.SplitPane({
      direction = 'Down',
      size = { Percent = 25 },
    }),
  },
}

wezterm.on('update-right-status', function(window, _)
  local leader = ''
  if window:leader_is_active() then
    leader = 'LEADER'
  end
  window:set_right_status(leader)
end)

config.scrollback_lines = 10000
local scrollback = require('scrollback')
scrollback.apply_to_config(config)

local sessions = require('sessions')
sessions.apply_to_config(config)

smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META|SHIFT', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
  -- log level to use: info, warn, error
  log_level = 'info',
})

return config
