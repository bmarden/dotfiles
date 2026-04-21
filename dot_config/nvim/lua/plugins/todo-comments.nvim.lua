return {
  "folke/todo-comments.nvim",
  opts = {
    search = {
      pattern = [[\b(KEYWORDS)(\([^)]*\))?:]], -- allow optional (tag) before colon, e.g. TODO(human):
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)%(\([^)]*\))?\s*:]], -- Vim regex (very magic), allow optional (tag) before colon
    },
  },
}
