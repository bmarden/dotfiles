return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
    },
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.expand("$HOME/.markdownlint-cli2.yaml"), "--" },
      },
      tflint = {
        args = { "--config", vim.fn.expand("$HOME/.tflint.hcl") },
      },
    },
  },
}
