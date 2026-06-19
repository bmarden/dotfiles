-- Workaround: some language servers advertise `workspace.fileOperations`
-- filters with a malformed glob `**/*.{}` (empty brace expansion when the
-- server has no registered file extensions). Neovim 0.12's `vim.glob.to_lpeg`
-- asserts on it, which breaks mini.files synchronize on delete/rename:
--   E5108: Invalid glob: **/*.{}
-- Strip such filters from each client's capabilities on attach.
return {
  "neovim/nvim-lspconfig",
  opts = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_glob_fix", { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local file_ops = client and vim.tbl_get(client, "server_capabilities", "workspace", "fileOperations")
        if not file_ops then
          return
        end
        for _, cap in pairs(file_ops) do
          if type(cap) == "table" and type(cap.filters) == "table" then
            cap.filters = vim.tbl_filter(function(f)
              local glob = vim.tbl_get(f or {}, "pattern", "glob")
              return not (type(glob) == "string" and glob:find("{}", 1, true))
            end, cap.filters)
          end
        end
      end,
    })
  end,
}
