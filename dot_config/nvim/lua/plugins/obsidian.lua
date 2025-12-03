local get_note_id = function(title)
  if title == nil then
    return ""
  end
  local date_prefix = os.date("%Y-%m-%d")
  local name = title:lower()
  return date_prefix .. "_" .. name
end

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
        name = "ben-brain",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ben-brain",
      },
    },
    notes_subdir = "inbox",
    new_note_location = "notes_subdir",
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d-%a",
      substitutions = {
        formatted_title = function(ctx)
          ---@diagnostic disable-next-line:param-type-mismatch
          -- The title should be in kebab-case already. To format it for the {{formatted_title}} substitution,
          -- we want to take the kebab-case title and convert it to Title Case.
          local formatted_title = ctx.partial_note.title:gsub("%-", " "):gsub("(%a)([%w]*)", function(first, rest)
            return first:upper() .. rest:lower()
          end)
          return formatted_title
        end,
      },
      customizations = {
        meeting = {
          note_id_func = get_note_id,
          notes_subdir = "meetings",
        },
        new = {
          note_id_func = get_note_id,
          notes_subdir = "inbox",
        },
      },
    },
    daily_notes = {
      folder = "daily-notes",
      template = "templates/daily.md",
      date_format = "%Y/%b/%Y-%m-%d-%a",
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
