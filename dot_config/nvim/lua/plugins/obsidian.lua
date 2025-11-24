return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  dependencies = {
    "folke/snacks.nvim",
    "saghen/blink.cmp",
  },
  event = "VeryLazy",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = "notes",
        path = "~/vaults/notes",
      },
    },
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d-%a",
      customizations = {
        meeting = {
          note_id_func = function(title)
            if title == nil then
              return ""
            end

            local name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            return name -- "Hulk Hogan" → "hulk-hogan"
          end,
          notes_subdir = "Meetings",
        },
      },
    },
    daily_notes = {
      folder = "DailyNotes",
      template = "Templates/daily-note.md",
    },
    picker = {
      name = "snacks.pick",
    },
    completion = {
      blink = true,
    },
    checkbox = {
      enabled = true,
      create_new = true,
      order = { " ", "x" },
    },
  },
}
