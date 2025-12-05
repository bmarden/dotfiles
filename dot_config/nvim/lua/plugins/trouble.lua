return {
  "folke/trouble.nvim",
  -- opts will be merged with the parent spec
  opts = {
    -- Filter out node_modules from diagnostics
    filter = function(items)
      return vim.tbl_filter(function(item)
        return not string.find(item.filename, "node_modules")
      end, items)
    end,
  },
}
