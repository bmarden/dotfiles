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
    "tiagovla/tokyodark.nvim",
  },
  {
    "rebelot/kanagawa.nvim",
  },
  -- {
  --   "navarasu/onedark.nvim",
  --   priority = 1000,
  --   opts = {
  --     style = "deep",
  --   },
  -- },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "onedark",
      colorscheme = "onedark_vivid",
    },
  },
}
