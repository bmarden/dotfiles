return {

  {
    "olimorris/onedarkpro.nvim",
    opts = {
      colors = {
        bg = "#111317", -- Custom background color
      },
      highlights = {
        -- Semantic token overrides
        ["@lsp.typemod.function.declaration.typescript"] = { link = "@function" },
        ["@lsp.typemod.function.local.typescript"] = { link = "@function" },

        -- Background overrides
        -- Normal = { bg = "${bg}" }, -- Apparently this breaks snacks.gh popup menu
        SignColumn = { bg = "${bg}" },
        LineNr = { bg = "${bg}" },
        CursorLineNr = { bg = "${bg}" },
        StatusLine = { bg = "${bg}" },
        StatusLineNC = { bg = "${bg}" },
        WinBar = { bg = "${bg}" },
        WinBarNC = { bg = "${bg}" },

        -- Visual mode highlight - blue-gray for better contrast
        Visual = { bg = "#3e4451", fg = "#ffffff" },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none", -- Transparent gutter
            },
          },
        },
      },
    },
  },
  -- Using lazy.nvim
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        bg0 = "#111317", -- Custom background color
        -- bg0 = "#252623",
      },
      highlights = {
        -- make comments blend nicely with background, similar to other color schemes
        ["@comment"] = { fg = "$grey" },
      },
    },
    -- config = function()
    --   require("bamboo").setup({
    --     -- optional configuration here
    --   })
    --   require("bamboo").load()
    -- end,
  },
  -- {
  --   "navarasu/onedark.nvim",
  --   priority = 1000,
  --   opts = {
  --     style = "deep",
  --   },
  -- },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  { "folke/tokyonight.nvim", opts = {
    style = "night",
  } },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "onedark",
      -- colorscheme = "onedark_vivid",
      -- colorscheme = "tokyonight",
      colorscheme = "bamboo",
    },
  },
}
