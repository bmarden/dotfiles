-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = ","

-- Avoids conflicts between prettier and biome
vim.g.lazyvim_prettier_needs_config = true

-- Ensures that using <leader>ff or <leader><space> opens the file finder in the current working directory
vim.g.root_spec = { "cwd" }

vim.opt.swapfile = false

-- Make spell checking take into account camelCase words (e.g., "camelCase" is treated as two words: "camel" and "Case")
vim.opt.spelloptions = "camel"

-- Enable diffs.nvim integrations
vim.g.diffs = {
  integrations = {
    neogit = true,
    gitsigns = true,
  },
  highlights = {
    treesitter = { max_lines = 1000 }, -- default: 500
    vim = { max_lines = 500 }, -- default: 200
  },
}

-- Enable live preview of substitutions in a split window (e.g., :%s/foo/bar/)
-- vim.opt.inccommand = "split"
