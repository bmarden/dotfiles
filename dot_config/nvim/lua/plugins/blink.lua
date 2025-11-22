return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<Tab>"] = {
          "snippet_forward",
          function() -- sidekick next edit suggestion
            return require("sidekick").nes_jump_or_apply()
          end,
          "fallback",
        },
      },
      completion = {
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
