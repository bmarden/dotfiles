---@module 'snacks'
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      -- dashboard = {
      --   preset = {
      --     keys = {
      --       { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
      --       { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      --       { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
      --       { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
      --       { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
      --       { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
      --       { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      --     },
      --   },
      -- },
      dashboard = {
        enabled = true,
      },
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },

          explorer = {
            hidden = true,
            ignored = true,
            exclude = { ".git" },
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
