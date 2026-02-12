return {
  "nvim-mini/mini.surround",
  opts = {
    mappings = {
      add = "sa",
      delete = "sd",
      find = "sf",
      find_left = "sF",
      highlight = "sh",
      replace = "sr",
      update_n_lines = "sn",
      -- Disable suffix mappings to avoid conflicts
      suffix_last = "",
      suffix_next = "",
    },
  },
  keys = {
    { "sa", desc = "Add surrounding", mode = { "n", "v" } },
    { "sd", desc = "Delete surrounding" },
    { "sf", desc = "Find right surrounding" },
    { "sF", desc = "Find left surrounding" },
    { "sh", desc = "Highlight surrounding" },
    { "sr", desc = "Replace surrounding" },
    { "sn", desc = "Update n_lines" },
  },
}
