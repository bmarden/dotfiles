local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- insert --
-- press jk fast to exit insert mode
keymap("i", "jk", "<esc>", opts) -- Insert mode -> jk -> Normal mode
keymap("i", "kj", "<esc>", opts) -- Insert mode -> kj -> Normal mode

-- visual --
-- stay in indent mode
keymap("v", ">", ">gv", opts) -- Left Indentation
keymap("v", "<", "<gv", opts) -- Right Indentation

keymap('n', '<leader>n', ':noh<CR>', { noremap = true, silent = true })


if vim.g.vscode then
  local vscode = require("vscode-neovim")

  keymap('n', '<C-j>', '',
    { callback = function() vscode.call('workbench.action.navigateDown') end, noremap = true, silent = true })
  keymap('x', '<C-j>', '',
    { callback = function() vscode.call('workbench.action.navigateDown') end, noremap = true, silent = true })
  keymap('n', '<C-k>', '',
    { callback = function() vscode.call('workbench.action.navigateUp') end, noremap = true, silent = true })
  keymap('x', '<C-k>', '',
    { callback = function() vscode.call('workbench.action.navigateUp') end, noremap = true, silent = true })
  keymap('n', '<C-h>', '',
    { callback = function() vscode.call('workbench.action.navigateLeft') end, noremap = true, silent = true })
  keymap('x', '<C-h>', '',
    { callback = function() vscode.call('workbench.action.navigateLeft') end, noremap = true, silent = true })
  keymap('n', '<C-l>', '',
    { callback = function() vscode.call('workbench.action.navigateRight') end, noremap = true, silent = true })
  keymap('x', '<C-l>', '',
    { callback = function() vscode.call('workbench.action.navigateRight') end, noremap = true, silent = true })

else
  -- Normal --
  -- Better window navigation
  keymap("n", "<C-h>", "<C-w>h", opts) -- left window
  keymap("n", "<C-k>", "<C-w>k", opts) -- up window
  keymap("n", "<C-j>", "<C-w>j", opts) -- down window
  keymap("n", "<C-l>", "<C-w>l", opts) -- right window

  -- Resize with arrows when using multiple windows
  keymap("n", "<C-Up>", ":resize -2<CR>", opts)
  keymap("n", "<c-down>", ":resize +2<cr>", opts)
  keymap("n", "<c-right>", ":vertical resize -2<cr>", opts)
  keymap("n", "<c-left>", ":vertical resize +2<cr>", opts)

  -- navigate buffers
  keymap("n", "<tab>", ":bnext<cr>", opts)          -- Next Tab
  keymap("n", "<s-tab>", ":bprevious<cr>", opts)    -- Previous tab
  keymap("n", "<leader>h", ":nohlsearch<cr>", opts) -- No highlight search

  -- Shortcuts for splitting windows
  keymap("n", "<leader>h", ":split<CR>", { noremap = true, silent = true })
  keymap("n", "<leader>v", ":vsplit<CR>", { noremap = true, silent = true })
end
