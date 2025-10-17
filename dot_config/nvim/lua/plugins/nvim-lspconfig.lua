return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
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
    },
    setup = {
      gopls = function(_, opts)
        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        LazyVim.lsp.on_attach(function(client, bufnr)
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        end, "gopls")
        -- end workaround
      end,
    },
  },
}
