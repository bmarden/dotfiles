return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
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
              buildFlags = { "-tags=integration,tools" },
              testTags = "integration",
            },
          },
        },
        gh_actions_ls = {
          init_options = {
            sessionToken = vim.env.GH_ACTIONS_PAT,
            repos = (function()
              local repo = require("config.utils").get_github_repo_config()
              if repo then
                return { repo }
              end
              return {}
            end)(),
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
        cssls = {
          settings = {
            css = {
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        tsgo = {
          enabled = false,
        },
        vtsls = {
          enabled = true,
          keys = {
            { "<leader>co", enabled = false },
          },
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
                preferTypeOnlyAutoImports = true,
              },
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
