return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  enabled = true,
  opts = {
    diff_opts = {
      layout = 'unified',
      keep_terminal_focus = true,
    },
  },
}
