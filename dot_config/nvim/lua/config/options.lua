-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = ","

-- Avoids conflicts between prettier and biome
vim.g.lazyvim_prettier_needs_config = true

-- Ensures that using <leader>ff or <leader><space> opens the file finder in the current working directory
vim.g.root_spec = { "cwd" }

vim.opt.swapfile = false
