return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {},
      completion = {

        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
      },
      enabled = function()
        return not vim.tbl_contains({ "tex" }, vim.bo.filetype) and vim.bo.buftype ~= "prompt"
      end,
    },
  },
}
