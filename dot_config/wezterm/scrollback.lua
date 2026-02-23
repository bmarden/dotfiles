---@diagnostic disable: assign-type-mismatch
local wezterm = require('wezterm') ---@type Wezterm
local io = require('io')
local os = require('os')
local act = wezterm.action

local module = {}

local function setup_scrollback_event()
  wezterm.on('trigger-vim-with-scrollback', function(window, pane)
    -- Retrieve the text from the pane
    local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
    wezterm.log_error('Retrieved scrollback text: ' .. text)

    -- Create a temporary file to pass to vim
    local name = os.tmpname()
    local f = io.open(name, 'w+')
    if not f then
      wezterm.log_error('Failed to create temporary file: ' .. name)
      return
    end

    f:write(text)
    f:flush()
    f:close()

    -- Open a new window running vim and tell it to open the file
    window:perform_action(
      act.SpawnCommandInNewTab({
        args = { '/Users/bmarden/.local/share/bob/nvim-bin/nvim', name },
      }),
      pane
    )

    -- Wait "enough" time for vim to read the file before we remove it.
    -- The window creation and process spawn are asynchronous wrt. running
    -- this script and are not awaitable, so we just pick a number.
    --
    -- Note: We don't strictly need to remove this file, but it is nice
    -- to avoid cluttering up the temporary directory.
    wezterm.sleep_ms(1000)
    os.remove(name)
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
  wezterm.log_error('scrollback: keybinding registered, total keys: ' .. #config.keys)
end

return module
