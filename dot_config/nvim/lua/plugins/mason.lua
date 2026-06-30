return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {
        "ansible-lint",
        "biome",
        "cmakelang",
        "cmakelint",
        "css-lsp",
        "css-variables-language-server",
        "delve",
        "gofumpt",
        "goimports",
        "hadolint",
        "js-debug-adapter",
        "markdown-toc",
        "markdownlint-cli2",
        "mypy",
        "prettier",
        "shfmt",
        "stylua",
        "tflint",
      }
    end,
  },
}
