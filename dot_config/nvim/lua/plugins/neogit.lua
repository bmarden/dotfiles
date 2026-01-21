return {
  "sotte/neogit",
  branch = "support-vscode-diff",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    -- "sindrets/diffview.nvim", -- optional - Diff integration
    "esmuellert/codediff.nvim",
    "folke/snacks.nvim",
  },
  cmd = "Neogit",

  config = function()
    -- require("diffview").setup({
    --   key_bindings = {
    --     file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
    --     file_panel = { q = "<Cmd>DiffviewClose<CR>" },
    --     view = { q = "<Cmd>DiffviewClose<CR>" },
    --   },
    -- })
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
    })
  end,
}
