return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
  opts = function(_, opts)
    opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({
      length = 6,
    }) }

    opts.options = vim.tbl_deep_extend("force", opts.options, {
      globalstatus = true,
      disabled_filetypes = {
        statusline = { "atlas" },
        winbar = {},
      },
    })
  end,
}
