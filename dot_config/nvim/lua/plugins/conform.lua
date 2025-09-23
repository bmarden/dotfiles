return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "golines", "gofumpt" },
    },
    formatters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.expand("$HOME/.markdownlint-cli2.yaml"), "--fix", "$FILENAME" },
      },
    },
  },
}
