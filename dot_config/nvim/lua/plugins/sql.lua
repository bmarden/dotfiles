return {
  -- Import LazyVim SQL extras for proper SQL support
  { import = "lazyvim.plugins.extras.lang.sql" },

  -- Configure mason to ensure SQL tools are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "sqlfluff", -- SQL linter
        -- "sql-formatter", -- SQL formatter
      },
    },
  },

  -- Configure conform for SQL formatting
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      sqlfluff = {
        args = { "fix", "--force", "--dialect=postgres", "-" },
      },
    },
    formatters_by_ft = {
      sql = { "sqlfluff" },
    },
  },

  -- Configure nvim-lint for SQL
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sql = { "sqlfluff" },
      },
      linters = {
        sqlfluff = {
          args = {
            "lint",
            "--format=json",
            "--dialect=postgres", -- Set PostgreSQL dialect
            "--stdin-filename",
            "%filepath",
            "-",
          },
        },
      },
    },
  },
}

