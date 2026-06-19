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
}
