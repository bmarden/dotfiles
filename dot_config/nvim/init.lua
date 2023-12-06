require("keymaps")
require("settings")
require("lazy-config")
require("hop-config")
require("lualine-config")
require('mini.move').setup()  -- Move lines and blocks of text
require('autocmd-config')

if vim.g.vscode then
  require("vscode-multi-cursor-config")
else
  require("bufferline-config")    -- File tab management
  require("nvim-tree-config")     -- File explorer
  require("treesitter-config")    -- Syntax highlighting
  require("lsp-config")           -- Language server protocol
  require("whichkey")             -- Quick keybinds
  require("neodev").setup({})     -- Neovim development environment
  vim.cmd [[colorscheme onedark_vivid]]
end

vim.cmd(string.format('let @%s="%s"', 'i', "f'l:s/\\\\(\\\\.\\\\+\\\\/\\\\)\\\\+/@\\\\/\\<CR>j"))
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
