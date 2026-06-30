return {
  "nvim-mini/mini.cursorword",
  event = "LazyFile",
  opts = {
    delay = 100,
  },
  config = function(_, opts)
    require("mini.cursorword").setup(opts)
    local function set_hl()
      vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true })
    end
    set_hl()
    vim.api.nvim_create_autocmd("ColorScheme", {
      desc = "Reapply mini.cursorword underline after colorscheme change",
      callback = set_hl,
    })
  end,
}
