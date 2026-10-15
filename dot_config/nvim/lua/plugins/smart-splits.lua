return {
  'smart-splits-nvim/smart-splits.nvim',
  lazy = false,
  dependencies = {
    {
      'smart-splits-nvim/backend-kitty',
      module = 'smart-splits-backend-kitty',
      opts = {
        password = (function()
          local file = io.open(vim.fn.expand('~/.config/kitty/rc-pass'))
          if not file then
            return nil
          end
          local pw = file:read('*a'):gsub('%s+$', '')
          file:close()
          return pw
        end)(),
        -- password = vim.env.KITTY_REMOTE_PASSWORD,
      },
    },
  },
  opts = {
    mux = {
      backend = 'smart-splits-backend-kitty',
    },
  },
}
