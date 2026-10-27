return {
  "esmuellert/codediff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  opts = {
    keymaps = {
      view = {
        next_hunk = "]h",
        prev_hunk = "[h",
      },
    },
  },
}
