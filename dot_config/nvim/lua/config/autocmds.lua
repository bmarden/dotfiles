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

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("organise_imports", { clear = true }),
  pattern = { "*.ts", "*.tsx", "*.mts", "*.cts" },
  callback = function(args)
    local buf = args.buf
    if vim.b[buf].organising_imports then
      vim.b[buf].organising_imports = nil
      return
    end

    local client = vim.lsp.get_clients({ bufnr = buf, name = "tsgo" })[1]
    if not client then
      return
    end

    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = {
      only = { "quickfix" },
      diagnostics = vim.lsp.diagnostic.from(vim.diagnostic.get(buf)),
    }

    client:request("textDocument/codeAction", params, function(_, result)
      for _, action in ipairs(result or {}) do
        if action.title == "Add all missing imports" and action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
          vim.b[buf].organising_imports = true
          vim.api.nvim_buf_call(buf, function()
            vim.cmd("noautocmd write")
          end)
          break
        end
      end
    end, buf)
  end,
})
