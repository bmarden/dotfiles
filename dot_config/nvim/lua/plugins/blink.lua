return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {},
      sources = {
        providers = {
          dadbod_grip = { name = "Grip SQL", module = "dadbod-grip.completion.blink" },
        },
      },
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
