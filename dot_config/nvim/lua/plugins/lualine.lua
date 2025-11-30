return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = vim.env.KITTY_SCROLLBACK_NVIM == nil,
  opts = function(_, opts)
    opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({
      length = 6,
    }) }
  end,
}
