return {
  "andythigpen/nvim-coverage",
  version = "*",
  keys = {
    { "<leader>tc", "<cmd>Coverage<cr>", desc = "Coverage in gutter" },
    { "<leader>tC", "<cmd>CoverageLoad<cr><cmd>CoverageSummary<cr>", desc = "Coverage summary" },
  },
  opts = {
    auto_reload = true,
    lang = {
      go = {
        coverage_file = vim.fn.getcwd() .. "/coverage/coverage.out",
      },
    },
  },
}
