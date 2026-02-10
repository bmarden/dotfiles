return {
  "folke/noice.nvim",
  opts = {
    presets = {
      bottom_search = false,
      -- Enables a border around hover popup menus
      lsp_doc_border = true,
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = {
          skip = true,
        },
      },
    },
  },
}
