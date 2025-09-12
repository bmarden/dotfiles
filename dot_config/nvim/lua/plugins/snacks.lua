return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      explorer = {},
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = { hidden = true, show_unloaded = true, ignored = true, exclude = { ".git" } },
        },
      },
    },
  },
}
