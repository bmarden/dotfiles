return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "darianmorat/gruvdark.nvim" },

  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    name = "onedarkpro",
    priority = 1000, -- Ensure it loads first
    opts = {
      -- theme = "onedark_dark", -- Specify the theme variant
      colors = {
        bg = "#111317", -- Custom background color
      },
      highlights = {
        -- Semantic token overrides
        ["@lsp.typemod.function.declaration.typescript"] = { link = "@function" },
        ["@lsp.typemod.function.local.typescript"] = { link = "@function" },

        -- Background overrides
        Normal = { bg = "${bg}" },
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

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark_vivid",
    },
  },
}
