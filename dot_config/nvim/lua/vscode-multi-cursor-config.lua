local vscode = require("vscode-neovim")

local status_ok, multi = pcall(require, "vscode-multi-cursor")
if not status_ok then
  return
end

print(vscode.call("_ping"))
multi.setup {
  default_mappings = true,
  -- If set to true, only multiple cursors will be created without multiple selections
  no_selection = false
}
local k = vim.keymap.set
-- k({ 'n' }, '<Char-0xAA>', )
k({ 'n', 'x' }, 'mc', multi.create_cursor, { expr = true, desc = 'Create cursor' })
k({ 'n' }, 'mcc', multi.cancel, { desc = 'Cancel/Clear all cursors' })
k({ 'n', 'x' }, 'mi', multi.start_left, { desc = 'Start cursors on the left' })
k({ 'n', 'x' }, 'mI', multi.start_left_edge, { desc = 'Start cursors on the left edge' })
k({ 'n', 'x' }, 'ma', multi.start_right, { desc = 'Start cursors on the right' })
k({ 'n', 'x' }, 'mA', multi.start_right, { desc = 'Start cursors on the right' })
k({ 'n' }, '[mc', multi.prev_cursor, { desc = 'Goto prev cursor' })
k({ 'n' }, ']mc', multi.next_cursor, { desc = 'Goto next cursor' })
vim.keymap.set('n', '<M-d>', 'mciw*<Cmd>nohl<CR>', { remap = true })
k({ 'n' }, 'mcs', multi.flash_char, { desc = 'Create cursor using flash' })
k({ 'n' }, 'mcw', multi.flash_word, { desc = 'Create selection using flash' })
