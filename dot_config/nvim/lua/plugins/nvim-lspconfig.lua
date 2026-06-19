return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
      servers = {
        ["*"] = {
          keys = {
            { "<leader>r", false },
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
            repos = {},
          },
          on_init = function(client)
            require("config.utils").get_github_repo_config(function(repo)
              if repo then
                client.config.init_options = client.config.init_options or {}
                client.config.init_options.repos = { repo }
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings or {} })
              end
            end)
          end,
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
        pyright = {
          on_attach = function(client)
            client.handlers["textDocument/publishDiagnostics"] = function() end
          end,
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
        terraformls = {
          init_options = {
            -- skip eager validation that triggers full provider schema decode
            experimentalFeatures = {
              validateOnSave = false,
              prefillRequiredFields = false,
            },
          },
          flags = {
            debounce_text_changes = 300,
          },
          -- Semantic tokens resolve every token against the provider schema. With
          -- a large provider (e.g. datadog, ~60MB schema) each pass takes seconds
          -- and re-fires on redraw, spinning the editor. Drop the capability for
          -- roots that use such a provider so highlighting falls back to treesitter;
          -- completion/hover/diagnostics stay. Other terraform roots keep full tokens.
          on_attach = function(client)
            local root = client.config.root_dir
            if not root then
              return
            end
            local lock = root .. "/.terraform.lock.hcl"
            local ok, lines = pcall(vim.fn.readfile, lock)
            if
              ok
              and vim.iter(lines):any(function(l)
                return l:match("registry%.terraform%.io/datadog/datadog")
              end)
            then
              client.server_capabilities.semanticTokensProvider = nil
            end
          end,
        },
      },
    },
  },
}
