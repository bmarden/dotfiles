if not vim.g.vscode then
  -- Indentation settings
  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  vim.o.smarttab = true
  vim.o.expandtab = true
  vim.o.smartindent = true
  vim.o.autoindent = true
  vim.o.wrap = false
  vim.o.encoding = 'utf-8'
  vim.o.pumheight = 10
  vim.o.timeoutlen = 750
  vim.o.fileencoding = 'utf-8'
  vim.o.ruler = true
  vim.o.mouse = 'a'
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.termguicolors = true
  vim.o.cmdheight = 2
  vim.o.laststatus = 2
  vim.o.cursorline = true
  vim.o.background = 'dark'
  vim.o.showtabline = 2
  vim.o.showmode = false
  vim.o.hlsearch = true
  vim.o.guifont = 'Fira Code Nerd Font'
end


-- Interface and visual settings
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.incsearch = true
vim.o.number = true

-- Prevents vim from automatically inserting a comment leader when pressing o or O
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Macros
-- Replaces `../../` with `@/` and jumps to the next match
vim.cmd(string.format('let @%s="%s"', 'i', "f'l:s/\\\\(\\\\.\\\\+\\\\/\\\\)\\\\+/@\\\\/\\<CR>j"))
