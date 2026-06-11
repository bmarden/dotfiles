-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Prevent markdown_oxide from attaching to non-markdown files
-- Wrap buf_attach_client to filter these out before attachment happens
local _original_buf_attach_client = vim.lsp.buf_attach_client
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf_attach_client = function(bufnr, client_id)
  local client = vim.lsp.get_client_by_id(client_id)

  -- Only allow markdown_oxide to attach to markdown files
  if client and client.name == "markdown_oxide" then
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if filetype ~= "markdown" then
      return false
    end
  end

  return _original_buf_attach_client(bufnr, client_id)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 100
  end,
})

local relnum = vim.api.nvim_create_augroup("relnum_toggle", { clear = true })

-- Disable relative numbers when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = relnum,
  callback = function()
    -- Make sure we're in a buffer that has numbers enabled before disabling relative numbers
    if vim.opt_local.number:get() then
      vim.opt_local.relativenumber = false
    end
  end,
})
-- Re-enable relative numbers when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = relnum,
  callback = function()
    -- Make sure we're in a buffer that has numbers enabled before enabling relative numbers
    if vim.opt_local.number:get() then
      vim.opt_local.relativenumber = true
    end
  end,
})
