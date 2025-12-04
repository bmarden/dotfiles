return {
  "stevearc/conform.nvim",
  enabled = vim.env.KITTY_SCROLLBACK_NVIM == nil,
  opts = {
    formatters_by_ft = {
      go = { "golangci-lint" },
      sql = { "sqlfluff" },
      javascript = { "biome-check", "prettier", stop_after_first = true },
      javascriptreact = { "biome-check", "prettier", stop_after_first = true },
      typescript = { "biome-check", "prettier", stop_after_first = true },
      typescriptreact = { "biome-check", "prettier", stop_after_first = true },
      json = { "biome-check", "prettier" },
    },
    formatters = {
      biome = {
        require_cwd = true,
      },
      ["biome-check"] = {
        require_cwd = true,
      },
      prettier = {
        require_cwd = true,
      },
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
