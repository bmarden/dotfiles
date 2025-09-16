return {
  "lewis6991/gitsigns.nvim",
  keys = {
    {
      "<leader>hb",
      "<cmd>Gitsigns blame_line<cr>",
      desc = "Blame Line",
    },
    {
      "<leader>hs",
      "<cmd>Gitsigns stage_hunk<cr>",
      desc = "Stage Hunk",
    },
    {
      "<leader>hS",
      "<cmd>Gitsigns stage_buffer<cr>",
      desc = "Stage Buffer",
    },
    {
      "<leader>hr",
      "<cmd>Gitsigns reset_hunk<cr>",
      desc = "Reset Hunk",
    },
    {
      "<leader>hs",
      "<cmd>Gitsigns stage_hunk<cr>",
      mode = "v",
      desc = "Stage Selection",
    },
    {
      "<leader>hr",
      "<cmd>Gitsigns reset_hunk<cr>",
      mode = "v",
      desc = "Reset Selection",
    },
    {
      "<leader>hR",
      "<cmd>Gitsigns reset_buffer<cr>",
      desc = "Reset Buffer",
    },
    {
      "<leader>hu",
      "<cmd>Gitsigns undo_stage_hunk<cr>",
      desc = "Undo Stage Hunk",
    },
  },
}
