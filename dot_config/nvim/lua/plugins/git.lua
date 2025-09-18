return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>hb",
        "<cmd>Gitsigns blame_line<cr>",
        desc = "Blame Line",
      },
      {
        "<leader>hs",
        "<cmd>Gitsigns stage_hunk<cr>",
        desc = "Stage Hunk",
      },
      {
        "<leader>hS",
        "<cmd>Gitsigns stage_buffer<cr>",
        desc = "Stage Buffer",
      },
      {
        "<leader>hr",
        "<cmd>Gitsigns reset_hunk<cr>",
        desc = "Reset Hunk",
      },
      {
        "<leader>hs",
        "<cmd>Gitsigns stage_hunk<cr>",
        mode = "v",
        desc = "Stage Selection",
      },
      {
        "<leader>hr",
        "<cmd>Gitsigns reset_hunk<cr>",
        mode = "v",
        desc = "Reset Selection",
      },
      {
        "<leader>hR",
        "<cmd>Gitsigns reset_buffer<cr>",
        desc = "Reset Buffer",
      },
      {
        "<leader>hu",
        "<cmd>Gitsigns undo_stage_hunk<cr>",
        desc = "Undo Stage Hunk",
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed.
        -- "nvim-telescope/telescope.nvim", -- optional
        -- "ibhagwan/fzf-lua", -- optional
        -- "echasnovski/mini.pick", -- optional
        "folke/snacks.nvim", -- optional
      },
      cmd = "Neogit",
      config = function()
        require("neogit").setup({
          kind = "split", -- opens neogit in a split
          signs = {
            -- { CLOSED, OPENED }
            section = { "", "" },
            item = { "", "" },
            hunk = { "", "" },
          },
          integrations = { diffview = true }, -- adds integration with diffview.nvim
        })
      end,
    },
  },
}
