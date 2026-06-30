-- Sourced by nvim (`nvim -S`) when wezterm opens scrollback in a new tab.
-- Streams `wezterm cli get-text --escapes` for the source pane into a terminal
-- buffer (so nvim's terminal emulator renders ansi colors), positions the
-- cursor where it was in the live pane, and wires `q` to close + return.

local env = vim.env
local bin = env.WEZTERM_SCROLLBACK_BIN
local pane = env.WEZTERM_SCROLLBACK_PANE
local rows = tonumber(env.WEZTERM_SCROLLBACK_ROWS) or 100000
local viewport = tonumber(env.WEZTERM_SCROLLBACK_VIEWPORT) or vim.o.lines
local phys_top = tonumber(env.WEZTERM_SCROLLBACK_PHYS_TOP) or 0
local cursor_y = tonumber(env.WEZTERM_SCROLLBACK_CURSOR_Y) -- absolute row in scrollback

vim.o.number = false
vim.o.relativenumber = false
vim.o.signcolumn = 'no'

local function on_exit()
  vim.schedule(function()
    vim.cmd('stopinsert')

    local last = vim.fn.line('$')
    -- The bottom `viewport` lines of the buffer are the live screen. The cursor
    -- sat `cursor_y - phys_top` rows down from the top of that screen, so it is
    -- `viewport - (cursor_y - phys_top)` rows up from the last line.
    local target = last
    if cursor_y then
      local row_in_screen = cursor_y - phys_top -- 0-based row within visible screen
      local from_bottom = (viewport - 1) - row_in_screen
      if from_bottom > 0 then
        target = last - from_bottom
      end
    end
    if target < 1 then
      target = 1
    end
    vim.api.nvim_win_set_cursor(0, { target, 0 })
    vim.cmd('normal! zb') -- put that line near bottom of window

    -- `q` quits everything and closes the tab, returning focus to the prior
    -- wezterm tab (the shell you launched from). Terminal job is force-killed.
    vim.keymap.set('n', 'q', '<cmd>qa!<cr>', { buffer = true, nowait = true, silent = true })
  end)
end

vim.fn.jobstart(
  { bin, 'cli', 'get-text', '--pane-id', pane, '--start-line', tostring(-rows), '--escapes' },
  { term = true, on_exit = on_exit }
) -- spawn a terminal job to keep the buffer alive
