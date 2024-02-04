local function load_plugins()
  local plugins = {}

  local all_plugins = {
    -- Configures neodev for neovim development
    {
      "folke/neodev.nvim",
      cond = not vim.g.vscode,
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
      cond = false
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
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
    {
      "olimorris/onedarkpro.nvim",
      priority = 1000 -- Ensure it loads first
    },
    {
      'sainnhe/sonokai'
    },

    -- Language Support
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    -- Lualine
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons'
      },
    },
    {
      'github/copilot.vim'
    },
    -- Telescope (Fuzzy Finder)
    {
      'nvim-telescope/telescope.nvim',
      lazy = true,
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
      }
    },
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
