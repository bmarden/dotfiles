return {
  "folke/flash.nvim",
  opts = {},
  keys = {
    -- Disable default keybindings
    { "s", false, mode = { "n", "x", "o" } },
    { "S", false, mode = { "n", "o", "x" } },
    { "r", false, mode = { "o" } },
    { "R", false, mode = { "o", "x" } },
    { "<c-s>", false, mode = { "c" } },
    -- Remap with localleader prefix
    {
      "<localleader>s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "<localleader>S",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "<localleader>r",
      mode = { "o" },
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "<localleader>R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
