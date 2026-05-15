return {
  "stevearc/conform.nvim",
  enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
  opts = {
    formatters_by_ft = {
      go = { "golangci-lint" },
      sql = { "sqlfluff" },
      javascript = { "biome-check", "prettier", stop_after_first = true },
      javascriptreact = { "biome-check", "prettier", stop_after_first = true },
      typescript = { "biome-check", "prettier", stop_after_first = true },
      typescriptreact = { "biome-check", "prettier", stop_after_first = true },
      json = { "biome-check", "prettier" },
      markdown = { "markdownlint-cli2", "markdown-toc" },
      yaml = { "prettier_yaml" },
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
      prettier_yaml = {
        command = require("conform.formatters.prettier").command,
        args = require("conform.formatters.prettier").args,
        range_args = require("conform.formatters.prettier").range_args,
        cwd = require("conform.formatters.prettier").cwd,
        stdin = true,
      },
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.expand("$HOME/.markdownlint-cli2.yaml"), "--fix", "$FILENAME" },
      },
      sqlfluff = {
        prepend_args = { "--config", vim.fn.expand("$HOME/.config/nvim/.sqlfluff") },
      },
    },
  },
}
