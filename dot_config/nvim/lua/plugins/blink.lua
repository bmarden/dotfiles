return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      },
      completion = {

        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        -- ghost_text = {
        --   enabled = true,
        -- },
        -- menu = {
        --   auto_show = false,
        -- },
      },
      enabled = function()
        return not vim.tbl_contains({ "tex" }, vim.bo.filetype) and vim.bo.buftype ~= "prompt"
      end,
    },
  },
}
