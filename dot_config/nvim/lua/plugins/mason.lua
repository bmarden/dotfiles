-- Tools are installed with mise (~/.config/mise/conf.d/nvim-tools.toml). Mason stays around for
-- one-off :MasonInstall trials; see :MiseMissing for promoting them to mise.
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- Clears the lists LazyVim extras add so Mason never auto-installs
      opts.ensure_installed = {}
      -- mise-installed binaries win over leftover Mason ones
      opts.PATH = "append"
    end,
  },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
}
