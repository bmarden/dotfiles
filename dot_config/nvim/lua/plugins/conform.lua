return {
  "stevearc/conform.nvim",
  enabled = vim.env.KITTY_SCROLLBACK_NVIM == nil,
  opts = {
    formatters_by_ft = {
      go = { "golangci-lint" },
      sql = { "sqlfluff" },
      javascript = { "biome", "biome-organize-imports" },
      javascriptreact = { "biome", "biome-organize-imports" },
      typescript = { "biome", "biome-organize-imports" },
      typescriptreact = { "biome", "biome-organize-imports" },
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
