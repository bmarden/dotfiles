-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Map jk to exit
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Rename word under cursor
map("n", "<Leader>R", function()
  local word = vim.fn.expand("<cword>")
  vim.fn.feedkeys(
    ":%s/\\<" .. word .. "\\>//g" .. string.rep(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 2)
  )
end, { desc = "Rename word under cursor" })

-- Visual mode - rename selected text
map("v", "<Leader>R", function()
  -- Exit visual mode and get the selected text
  vim.cmd('normal! "vy')
  local selected_text = vim.fn.getreg("v")

  -- Escape special regex characters
  selected_text = vim.fn.escape(selected_text, "/\\[]^$.*~")

  -- Feed the substitute command
  vim.fn.feedkeys(
    ":%s/" .. selected_text .. "//g" .. string.rep(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 2)
  )
end, { desc = "Rename selected text" })

-- Shortcut to launch neogit
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "Neogit" })

-- Easier mapping for saving files
vim.keymap.set({ "x", "n", "s" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save File" })

-- By default, CTRL-U and CTRL-D scroll by half a screen (50% of the window height)
-- Scroll by 35% of the window height and keep the cursor centered
local scroll_percentage = 0.35
-- Scroll by a percentage of the window height and keep the cursor centered
vim.keymap.set("n", "<C-d>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "jzz")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "kzz")
end, { noremap = true, silent = true })

-- Quit or exit neovim, easier than to do <leader>qq
vim.keymap.set({ "n", "v", "i" }, "<M-q>", "<cmd>qa<cr>", { desc = "[P]Quit All" })
-- Close the current window

-- use gh to move to the beginning of the line in normal mode
-- use gl to move to the end of the line in normal mode
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "[P]Go to the beginning line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "[P]go to the end of the line" })

-- In visual mode, after going to the end of the line, come back 1 character
vim.keymap.set("v", "gl", "$h", { desc = "[P]Go to the end of the line" })

-- Setup some keybindings for obsidian.nvim
-- Change to vault directory before running commands to ensure templates are found
local vault_path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ben-brain")
vim.keymap.set("n", "<leader>od", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("cd " .. vault_path)
  vim.cmd("Obsidian today")
  vim.cmd("cd " .. cwd)
end, { desc = "Open Obsidian Daily Note" })

vim.keymap.set("n", "<leader>of", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("cd " .. vault_path)
  vim.cmd("Obsidian search")
  vim.cmd("cd " .. cwd)
end, { desc = "Find Obsidian Note" })

vim.keymap.set("n", "<leader>om", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("cd " .. vault_path)
  vim.ui.input({ prompt = "Meeting Title: " }, function(title)
    if title and title ~= "" then
      vim.cmd("Obsidian new_from_template " .. title .. " meeting")
    end
    vim.cmd("cd " .. cwd)
  end)
end, { desc = "Create Obsidian Meeting Note" })

vim.keymap.set("n", "<leader>on", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("cd " .. vault_path)
  vim.ui.input({ prompt = "Note Title: " }, function(title)
    if title and title ~= "" then
      vim.cmd("Obsidian new_from_template " .. title .. " new")
    end
    vim.cmd("cd " .. cwd)
  end)
end, { desc = "Create New Obsidian Note" })
vim.keymap.set("n", "<leader>ot", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("cd " .. vault_path)
  vim.cmd("Obsidian tags")
  vim.cmd("cd " .. cwd)
end, { desc = "Open Obsidian Tags" })

-- Neovim specific keybindings
if not vim.g.vscode then
  --  Set smart-splits keybindings
  vim.keymap.set("n", "<D-j>", require("smart-splits").resize_down)
  vim.keymap.set("n", "<D-h>", require("smart-splits").resize_left)
  vim.keymap.set("n", "<D-k>", require("smart-splits").resize_up)
  vim.keymap.set("n", "<D-l>", require("smart-splits").resize_right)
  -- moving between splits
  vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
  vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
  vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
  vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
  vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
  -- swapping buffers between windows
  vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
  vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
  vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
  vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
end

-- VSCode specific keybindings
if vim.g.vscode then
  local vscode = require("vscode")
  -- map({ "n", "v" }, "<leader>/", function()
  --   vscode.action("editor.action.commentLine")
  -- end)
  -- VSCode specific keymaps
  -- Setup C-Left, C-Right, C-Up, C-Down to resize all panes (editor, terminal, explorer)
  map(
    "n",
    "<C-Left>",
    "<Cmd>call VSCodeNotify('workbench.action.decreaseViewSize')<CR>",
    { desc = "Decrease view size" }
  )
  map(
    "n",
    "<C-Right>",
    "<Cmd>call VSCodeNotify('workbench.action.increaseViewSize')<CR>",
    { desc = "Increase view size" }
  )
  map("n", "<C-Up>", "<Cmd>call VSCodeNotify('workbench.action.increaseViewSize')<CR>", { desc = "Increase view size" })
  map(
    "n",
    "<C-Down>",
    "<Cmd>call VSCodeNotify('workbench.action.decreaseViewSize')<CR>",
    { desc = "Decrease view size" }
  )
end
