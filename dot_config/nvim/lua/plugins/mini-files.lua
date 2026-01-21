return {
  {
    "nvim-mini/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 50,
        width_preview = 100,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
      content = {
        filter = function(entry)
          return entry.name ~= ".DS_Store" and entry.name ~= ".git" and entry.name ~= "node_modules"
        end,
      },
    },
  },
}
