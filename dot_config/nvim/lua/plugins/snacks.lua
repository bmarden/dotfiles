---@module 'snacks'
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = vim.env.KITTY_SCROLLBACK_NVIM == nil,
        preset = {
          keys = {
            { icon = "", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = {
        replace_netrw = true,
      },
      lazygit = {
        -- Disabling for now in favor of neogit
        enabled = false,
        configure = false,
      },
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = {
            hidden = true,
            ignored = true,
            exclude = { ".git", "node_modules", ".DS_Store" },
            win = {
              list = {
                keys = {
                  ["]h"] = "explorer_git_next",
                  ["[h"] = "explorer_git_prev",
                  -- Set to false so our default mappings handle navigation
                  ["<c-h>"] = false, --
                  ["<c-j>"] = false,
                  ["<c-k>"] = false,
                  ["<c-l>"] = false,
                },
              },
            },
          },
        },
      },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 10, total = 100 },
          easing = "linear",
        },
        -- faster animation when repeating scroll after delay
        animate_repeat = {
          delay = 50, -- delay in ms before using the repeat animation
          duration = { step = 3, total = 20 },
          easing = "linear",
        },
      },
    },
  },
}
