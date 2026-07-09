return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
      sql = { "sqlfluff" },
      markdown = { "markdownlint-cli2" },
      python = { "mypy" },
    },
    linters = {
      -- Upstream golangcilint checks `go env GOMOD` at nvim's cwd and falls
      -- back to single-file linting when it's not inside a module (e.g. a
      -- monorepo root with per-directory Go modules). Single-file runs can't
      -- see sibling files, producing bogus `typecheck: undefined` errors.
      -- Pin the args (golangci-lint v2.1+) to always lint the buffer's dir.
      golangcilint = {
        args = {
          "run",
          "--output.json.path=stdout",
          "--output.text.path=",
          "--output.tab.path=",
          "--output.html.path=",
          "--output.checkstyle.path=",
          "--output.code-climate.path=",
          "--output.junit-xml.path=",
          "--output.teamcity.path=",
          "--output.sarif.path=",
          "--issues-exit-code=0",
          "--show-stats=false",
          "--path-mode=abs",
          function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          end,
        },
      },
      ["markdownlint-cli2"] = {
        prepend_args = { "--config", "/Users/bmarden/.markdownlint-cli2.yaml", "--" },
      },
      tflint = {
        args = { "--config", vim.fn.expand("$HOME/.tflint.hcl") },
      },
    },
  },
}
