local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup {
  keys = 'etovxqpdygfblzhckisuran'
}

local opts = {
  silent = true,
  noremap = true,
  callback = nil,
  desc = nil,
}

local directions = require('hop.hint').HintDirection
local keymap = vim.api.nvim_set_keymap

local bindings = {
  {
    mode = 'n',
    mapping = 's',
    desc = '',
    func = function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end
  },
  {
    mode = 'n',
    mapping = 'S',
    desc = '',
    func = function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end
  },
  {
    mode = 'n',
    mapping = 't',
    desc = '',
    func = function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end
  },
  {
    mode = 'n',
    mapping = 'T',
    desc = '',
    func = function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end
  },
  {
    mode = 'n',
    mapping = '<leader>w',
    desc = '',
    func = function() hop.hint_words( { direction = directions.AFTER_CURSOR }) end
  },
  {
    mode = 'n',
    mapping = '<leader>b',
    desc = '',
    func = function() hop.hint_words( { direction = directions.BEFORE_CURSOR }) end
  }
}

for _, binding in pairs(bindings) do
  opts.callback = binding.func
  opts.desc = binding.desc
  keymap(binding.mode, binding.mapping, '', opts)
end

-- vim.keymap.set('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})
