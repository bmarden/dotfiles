return {
  "3rd/image.nvim",
  build = false,
  -- enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
  enabled = false,
  opts = {
    backend = "kitty",
    processor = "magick_cli",
  },
}
