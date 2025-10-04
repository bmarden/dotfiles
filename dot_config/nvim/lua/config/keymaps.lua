-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Map jk to exit
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Rename word under cursor
map("n", "<Leader>r", function()
  local word = vim.fn.expand("<cword>")
  vim.fn.feedkeys(
    ":%s/\\<" .. word .. "\\>//g" .. string.rep(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 2)
  )
end, { desc = "Rename word under cursor" })

-- Visual mode - rename selected text
map("v", "<Leader>r", function()
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

-- Override the default <Leader>/ mapping to comment line
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment line" })

-- For visual mode (comment selection)
-- Use Comment.nvim's built-in visual mode mapping
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment selection" })

-- Shortcut to launch neogit
map("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "Neogit" })

if not vim.g.vscode then
  -- Override the default window navigation keymaps so they work with tmux plugin
  vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
  vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
  vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
  vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
  vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
  vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })
end
