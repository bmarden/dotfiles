require("keymaps")
require("settings")
require("lazy-config")
require("hop-config")
require("bufferline-config")
require("lualine-config")
require("whichkey")
require('mini.move').setup()

if vim.g.vscode then
  require("vscode-multi-cursor-config")
else
  vim.cmd [[colorscheme tokyonight]]
end
