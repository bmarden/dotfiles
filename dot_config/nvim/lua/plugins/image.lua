return {
  "3rd/image.nvim",
  build = false,
  enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
  opts = {
    backend = "kitty",
    processor = "magick_cli",
  },
  config = function(_, opts)
    local image = require("image")
    image.setup(opts)

    -- Patch hijack_buffer to handle mini.files' minifiles:// URI scheme
    local original_hijack = image.hijack_buffer
    ---@diagnostic disable-next-line: duplicate-set-field
    image.hijack_buffer = function(path, win, buf, options)
      local real_path = path:match("^minifiles://%d+/(.+)$")
      if real_path then
        path = real_path
      end
      return original_hijack(path, win, buf, options)
    end
  end,
}
