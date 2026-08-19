return {
  "joryeugene/dadbod-grip.nvim",
  -- tag = "v1.8.0",
  version = "*",
  enabled = true,
  keys = {
    { "<leader>D", "<cmd>GripToggle<cr>", desc = "DB Grip toggle" },
  },
  opts = {
    -- picker = "snacks",
    ai = false,
    completion = false,
  },
}
