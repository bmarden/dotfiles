return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
      sql = { "sqlfluff" },
      markdown = { "markdownlint-cli2" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        prepend_args = { "--config", "/Users/bmarden/.markdownlint-cli2.yaml", "--" },
      },
      tflint = {
        args = { "--config", vim.fn.expand("$HOME/.tflint.hcl") },
      },
    },
  },
}
