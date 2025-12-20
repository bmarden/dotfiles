return {
  "esmuellert/vscode-diff.nvim",
  branch = "next",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  opts = {
    keymaps = {
      view = {
        quit = "q", -- Close diff tab
        toggle_explorer = "<leader>b", -- Toggle explorer visibility (explorer mode only)
        next_hunk = "]h", -- Jump to next change
        prev_hunk = "[h", -- Jump to previous change
        next_file = "]f", -- Next file in explorer mode
        prev_file = "[f", -- Previous file in explorer mode
      },
    },
  },
}
