return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "esmuellert/codediff.nvim",
    "folke/snacks.nvim",
    "m00qek/baleia.nvim", -- For pretty git graphs
  },
  cmd = "Neogit",
  -- Temporary until fix implemented
  -- https://github.com/NeogitOrg/neogit/issues/2008
  init = function()
    -- Shim codediff.ui.view.create for legacy Neogit integration schema
    local ok, view = pcall(require, "codediff.ui.view")
    if ok and view.create then
      local original_create = view.create
      local path = require("codediff.core.path")

      view.create = function(session_config, filetype, on_ready)
        if session_config.mode == "explorer" and not session_config.panel then
          session_config.panel = {
            name = "explorer",
            data = session_config.explorer_data or {},
          }
          session_config.original = session_config.original or path.empty()
          session_config.modified = session_config.modified or path.empty()
        end
        return original_create(session_config, filetype, on_ready)
      end
    end
  end,

  config = function()
    require("neogit").setup({
      kind = "split", -- opens neogit in a split
      diff_viewer = "codediff", -- use codediff for diffs
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = { codediff = true, snacks = true },
      commit_editor = { kind = "floating" },
      graph_style = "kitty",
    })
  end,
}
