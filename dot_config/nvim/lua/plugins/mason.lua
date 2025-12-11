return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "sqlfluff",
        "css-lsp",
        "css-variables-language-server",
        "html-lsp",
      })
    end,
  },
}
