return {
  "folke/sidekick.nvim",
  enabled = false,
  keys = {
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "claude", focus = true })
      end,
      desc = "Sidekick Toggle Claude",
    },
  },
  opts = {
    nes = {
      enabled = false,
    },
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
      keys = {
        nav_left = {
          "<c-h>",
          function()
            require("smart-splits").move_cursor_left()
          end,
          mode = "nt",
          desc = "navigate left",
        },
        nav_down = {
          "<c-j>",
          function()
            require("smart-splits").move_cursor_down()
          end,
          mode = "nt",
          desc = "navigate down",
        },
        nav_up = {
          "<c-k>",
          function()
            require("smart-splits").move_cursor_up()
          end,
          mode = "nt",
          desc = "navigate up",
        },
        nav_right = {
          "<c-l>",
          function()
            require("smart-splits").move_cursor_right()
          end,
          mode = "nt",
          desc = "navigate right",
        },
      },
    },
  },
}
