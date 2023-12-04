-- local setup_ok, lsp = pcall(require, "lsp-zero")
-- if not setup_ok then
--   return
-- end
-- 
-- lsp.on_attach(function(client, bufnr)
--   lsp.default_keymaps({ buffer = bufnr })
-- end)
-- 
-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--   ensure_installed = {'bashls', 'tsserver'},
--   handlers = {
--     lsp_zero.default_setup,
--   },
-- })

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'bashls', 'tsserver', 'lua_ls'},
  handlers = {
    lsp_zero.default_setup,
  },
})
