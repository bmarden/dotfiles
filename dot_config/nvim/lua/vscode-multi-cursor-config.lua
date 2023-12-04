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
local map = vim.keymap.set
-- k({ 'n' }, '<Char-0xAA>', )
map({ 'n', 'x' }, 'mc', multi.create_cursor, { expr = true, desc = 'Create cursor' })
map({ 'n' }, 'mcc', multi.cancel, { desc = 'Cancel/Clear all cursors' })
map({ 'n', 'x' }, 'mi', multi.start_left, { desc = 'Start cursors on the left' })
map({ 'n', 'x' }, 'mI', multi.start_left_edge, { desc = 'Start cursors on the left edge' })
map({ 'n', 'x' }, 'ma', multi.start_right, { desc = 'Start cursors on the right' })
map({ 'n', 'x' }, 'mA', multi.start_right, { desc = 'Start cursors on the right' })
map({ 'n' }, '[mc', multi.prev_cursor, { desc = 'Goto prev cursor' })
map({ 'n' }, ']mc', multi.next_cursor, { desc = 'Goto next cursor' })
-- map('n', '<M-d>', 'mciw*<Cmd>nohl<CR>', { remap = true })
map({ 'n' }, 'mcs', multi.flash_char, { desc = 'Create cursor using flash' })
map({ 'n' }, 'mcw', multi.flash_word, { desc = 'Create selection using flash' })
map({ "n", "x", "i" }, "<M-d>", function()
  multi.addSelectionToNextFindMatch()
end)