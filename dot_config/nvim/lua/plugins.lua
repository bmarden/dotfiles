local function load_plugins()
  local plugins = {}

  local all_plugins = {
    -- Configures neodev for neovim development
    {
      "folke/neodev.nvim",
      cond = not vim.g.vscode,
    },

    -- Telescope (Fuzzy Finder)
    {
      'nvim-telescope/telescope.nvim',
      lazy = true,
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
      }
    },

    -- Alpha (Dashboard)
    {
      "goolord/alpha-nvim",
      lazy = true,
    },
    -- Hop (Better Navigation)
    {
      'smoka7/hop.nvim',
      version = "*",
      opts = {},
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({})
      end
    },
    {
      'vscode-neovim/vscode-multi-cursor.nvim',
      event = 'VeryLazy',
      cond = not not vim.g.vscode,
    },
    {
      'echasnovski/mini.nvim',
      version = false,
    },
  }

  -- Plugins to load when vim.g.vscode is true
  local vscode_plugins = {
  }

  -- Plugins to load when vim.g.vscode is false
  local neovim_plugins = {
    -- Bufferline
    {
      'akinsho/bufferline.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons'
      },
      cond = not vim.g.vscode,
    },
    -- Which-key
    {
      'folke/which-key.nvim',
      lazy = true,
    },
    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
    },
    -- Nvimtree (File Explorer)
    {
      'nvim-tree/nvim-tree.lua',
      lazy = true,
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
    },
    -- Colorscheme
    {
      'folke/tokyonight.nvim',
    },
    -- Language Support
    -- Added this plugin.
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },         -- Required
        { 'hrsh7th/cmp-nvim-lsp' },     -- Required
        { 'hrsh7th/cmp-buffer' },       -- Optional
        { 'hrsh7th/cmp-path' },         -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' },     -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip' },             -- Required
        { 'rafamadriz/friendly-snippets' }, -- Optional
      }
    },
    -- Lualine
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons'
      },
    },
    { 'github/copilot.vim' }
  }

  -- Add all plugins to the list
  for _, plugin in ipairs(all_plugins) do
    table.insert(plugins, plugin)
  end

  -- Conditional loading based on vim.g.vscode
  if vim.g.vscode then
    for _, plugin in ipairs(vscode_plugins) do
      table.insert(plugins, plugin)
    end
  else
    for _, plugin in ipairs(neovim_plugins) do
      table.insert(plugins, plugin)
    end
  end

  return plugins
end

return load_plugins()
