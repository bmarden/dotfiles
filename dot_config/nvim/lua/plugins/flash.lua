return {
  "folke/flash.nvim",
  opts = {},
  keys = {
    -- Disable this so it doesn't conflict with nvim-surround's 'S' mapping
    { "S", false, mode = { "x" } },
  },
}
