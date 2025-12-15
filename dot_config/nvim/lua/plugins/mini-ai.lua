return {
  "nvim-mini/mini.ai",
  opts = {
    -- Disable `t` for text objects so we can use the default neovim functionality for selecting between tags.
    -- More information here: https://github.com/LazyVim/LazyVim/issues/1413
    custom_textobjects = {
      t = false,
    },
  },
}
