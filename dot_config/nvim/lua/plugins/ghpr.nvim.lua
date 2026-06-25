return {
  dir = "/Users/bmarden/code-personal/nvim-plugins/ghpr.nvim",
  -- "bmarden/ghpr.nvim",
  enabled = true,
  dependencies = {
    "folke/snacks.nvim",
    "esmuellert/codediff.nvim",
  },
  cmd = {
    "GhPrCreate",
    "GhPrView",
    "GhPrEdit",
    "GhPrAddReviewer",
    "GhPrList",
    "GhPrReview",
    "GhPrReviewClose",
    "GhPrReviewRefresh",
    "GhPrReviewStats",
  },
  keys = {
    { "<leader>gc", "<cmd>GhPrCreate<cr>", desc = "Create GitHub PR" },
    { "<leader>gp", "<cmd>GhPrList<cr>", desc = "Pick GitHub PR" },
    { "<leader>gv", "<cmd>GhPrView<cr>", desc = "View PR description" },
    { "<leader>ge", "<cmd>GhPrEdit<cr>", desc = "Edit PR description" },
    { "<leader>gr", "<cmd>GhPrAddReviewer<cr>", desc = "Add PR reviewer" },
  },
  opts = {},
}
