-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Prevent gopls from attaching to octo://, diffview://, and diff mode buffers
-- Wrap buf_attach_client to filter these out before attachment happens
local _original_buf_attach_client = vim.lsp.buf_attach_client
vim.lsp.buf_attach_client = function(bufnr, client_id)
  local client = vim.lsp.get_client_by_id(client_id)

  -- Only filter gopls
  if client and client.name == "gopls" then
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    -- Check for special URI schemes
    if bufname:match("^octo://") or bufname:match("^diffview://") then
      return false
    end

    -- Check if buffer is in diff mode
    local winid = vim.fn.bufwinid(bufnr)
    if winid ~= -1 and vim.wo[winid].diff then
      return false
    end
  end

  return _original_buf_attach_client(bufnr, client_id)
end
