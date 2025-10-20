return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>w", hidden = true, desc = "Save file" },
      {
        "<leader>W",
        group = "windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
    },
  },
}
