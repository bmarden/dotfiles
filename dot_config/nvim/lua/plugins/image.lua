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

    -- mini.files integration.
    --
    -- Two problems, one shared preview buffer:
    --   1. image.nvim's hijack autocmd calls `hijack_buffer` with the buffer
    --      name, which for a mini.files preview is `minifiles://<id>/<path>`.
    --      `from_file` can't resolve that scheme -> "file not found" error.
    --   2. `hijack_buffer` leaves the buffer `nomodifiable`/`buftype=nowrite`.
    --      mini.files reuses that same buffer on `explorer_refresh` and calls
    --      `nvim_buf_set_lines` on it -> E5108 "Buffer is not 'modifiable'".
    --
    -- Fix: strip the scheme so the image resolves, then hand the buffer back to
    -- mini.files in a writable state. The rendered image is an overlay/extmark,
    -- not buffer content, so it survives; a later refresh re-triggers hijack and
    -- re-renders the cached image.
    local original_hijack = image.hijack_buffer
    ---@diagnostic disable-next-line: duplicate-set-field
    image.hijack_buffer = function(path, win, buf, options)
      local real_path = path:match("^minifiles://%d+/(.+)$")
      if not real_path then
        return original_hijack(path, win, buf, options)
      end

      local result = original_hijack(real_path, win, buf, options)

      if buf and vim.api.nvim_buf_is_valid(buf) then
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].modifiable = true
      end
      return result
    end
  end,
}
