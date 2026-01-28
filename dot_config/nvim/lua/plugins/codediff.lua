return {
  "esmuellert/codediff.nvim",
  branch = "next",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  opts = {
    keymaps = {
      view = {
        quit = "q", -- Close diff tab
        toggle_explorer = "<leader>b", -- Toggle explorer visibility (explorer mode only)
        next_file = "]f", -- Next file in explorer mode
        prev_file = "[f", -- Previous file in explorer mode
      },
    },
  },
}
