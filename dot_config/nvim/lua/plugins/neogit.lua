return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "esmuellert/codediff.nvim",
    "folke/snacks.nvim",
    "m00qek/baleia.nvim", -- For pretty git graphs
  },
  cmd = "Neogit",

  config = function()
    require("neogit").setup({
      kind = "split", -- opens neogit in a split
      diff_viewer = "codediff", -- use codediff for diffs
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = { codediff = true, snacks = true },
      commit_editor = { kind = "floating" },
      graph_style = "kitty",
    })
  end,
}
