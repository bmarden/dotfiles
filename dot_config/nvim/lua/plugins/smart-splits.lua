return {
  "smart-splits-nvim/smart-splits.nvim",
  lazy = false,
  dependencies = { "smart-splits-nvim/backend-ghostty" },
  config = function()
    require("smart-splits").setup({})
    require("ghostty-smart-splits").setup()
  end,
}
