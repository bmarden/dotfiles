return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            {
              "<leader>r",

              function()
                local inc_rename = require("inc_rename")
                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
              end,
              expr = true,
              desc = "Rename (inc-rename.nvim)",
              has = "rename",
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
              analyses = {
                ST1003 = false,
              },
              staticcheck = false,
              semanticTokens = true,
            },
          },
        },
        gh_actions_ls = {
          settings = {
            init_options = {
              sessionToken = vim.env.GITHUB_TOKEN,
            },
          },
        },
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
          settings = {
            bashIde = {
              -- Disable unused variable warnings
              shellcheckArguments = { "-e", "SC2034" },
            },
          },
        },
        vtsls = {
          keys = {
            { "<leader>co", enabled = false },
          },
          settings = {
            typescript = {
              tsserver = {
                experimental = {
                  enableProjectDiagnostics = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
