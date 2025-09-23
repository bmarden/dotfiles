return {
  {
    "nvim-mini/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 50,
        width_preview = 80,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
    },
  },
}
