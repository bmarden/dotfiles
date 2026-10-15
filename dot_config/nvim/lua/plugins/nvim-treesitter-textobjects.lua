return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  opts = function(_, opts)
    -- Free ]C/[C for builtin multicursor navigation (:h ]C)
    local keys = opts.move.keys
    keys.goto_next_end[']C'] = nil
    keys.goto_previous_end['[C'] = nil
  end,
}
