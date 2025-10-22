return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      go = { "golangci-lint" },
      sql = { "sqlfluff" },
    },
    formatters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.expand("$HOME/.markdownlint-cli2.yaml"), "--fix", "$FILENAME" },
      },
      sqlfluff = {
        command = "sqlfluff",
        args = { "format", "--config", vim.fn.expand("$HOME/.config/nvim/.sqlfluff"), "-" },
        stdin = true,
        cwd = function()
          return vim.fn.getcwd()
        end,
      },
    },
  },
}
