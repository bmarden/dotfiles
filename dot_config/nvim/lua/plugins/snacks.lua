---@module 'snacks'
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },

          explorer = {
            hidden = true,
            ignored = true,
            exclude = { ".git" },
          },
        },
      },
    },
  },
}
