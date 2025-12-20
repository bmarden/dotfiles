return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
        numbers = function(opts)
          return string.format("%s", opts.raise(opts.ordinal))
        end,
      },
    },
  },
}
