local opts = {}

local enabled = true

local function toggle()
  local mp = require("markdown-plus")
  enabled = not enabled
  if enabled then
    mp.setup(opts)
    vim.notify("markdown-plus enabled", vim.log.levels.INFO)
  else
    mp.teardown()
    vim.notify("markdown-plus disabled", vim.log.levels.WARN)
  end
end

return {
  -- dir = "~/code-personal/markdown-plus.nvim",
  "yousefhadder/markdown-plus.nvim",
  ft = "markdown",
  enabled = true,
  opts = opts,
  keys = {
    { "<leader>uM", toggle, desc = "Toggle markdown-plus" },
  },
  init = function()
    -- markdown-plus skips its default keymap when a buffer-local one already
    -- exists, so claim [b/]b for buffer navigation before its setup runs.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function(ev)
        vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { buffer = ev.buf, desc = "Prev Buffer" })
        vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { buffer = ev.buf, desc = "Next Buffer" })
      end,
    })
  end,
}
