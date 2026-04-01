return {
  "nvim-mini/mini.files",
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (root dir)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
  init = function()
    require("config.minifiles")
  end,
  opts = {
    mappings = {
      -- synchronize = "<C-c><C-c>",
    },
    windows = {
      preview = true,
      width_focus = 50,
      width_preview = 100,
    },
    options = {
      use_as_default_explorer = true,
    },
    content = {
      filter = function(entry)
        return entry.name ~= ".DS_Store" and entry.name ~= ".git" and entry.name ~= "node_modules"
      end,
    },
  },
}
