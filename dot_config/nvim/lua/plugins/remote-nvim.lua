return {
  "amitds1997/remote-nvim.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim", -- For standard functions
    "MunifTanjim/nui.nvim", -- To build the plugin UI
    "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
  },
  config = true,
  opts = {
    remote = {
      copy_dirs = {
        -- What to copy to remote's Neovim config directory
        config = {
          base = vim.fn.stdpath("config"), -- Path from where data has to be copied
          dirs = { "lua/config" }, -- Directories that should be copied over. "*" means all directories. To specify a subset, use a list like {"lazy", "mason"} where "lazy", "mason" are subdirectories
          -- under path specified in `base`.
          compression = {
            enabled = false, -- Should compression be enabled or not
            additional_opts = {}, -- Any additional options that should be used for compression. Any argument that is passed to `tar` (for compression) can be passed here as separate elements.
          },
        },
        -- What to copy to remote's Neovim data directory
        -- data = {
        --   base = vim.fn.stdpath("data"),
        --   dirs = {},
        --   compression = {
        --     enabled = true,
        --   },
        -- },
        -- -- What to copy to remote's Neovim cache directory
        -- cache = {
        --   base = vim.fn.stdpath("cache"),
        --   dirs = {},
        --   compression = {
        --     enabled = true,
        --   },
        -- },
        -- -- What to copy to remote's Neovim state directory
        -- state = {
        --   base = vim.fn.stdpath("state"),
        --   dirs = {},
        --   compression = {
        --     enabled = true,
        --   },
        -- },
      },
    },
    client_callback = function(port, workspace_config)
      local cmd = ("wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s"):format(
        port,
        ("'Remote: %s'"):format(workspace_config.host)
      )
      if vim.env.TERM == "xterm-kitty" then
        cmd = ("kitty -e nvim --server localhost:%s --remote-ui"):format(port)
      end
      vim.fn.jobstart(cmd, {
        detach = true,
        on_exit = function(job_id, exit_code, event_type)
          -- This function will be called when the job exits
          print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
        end,
      })
    end,
  },
}
