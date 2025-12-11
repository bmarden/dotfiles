return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "bash",
      "css",
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gowork",
      "html",
      "html_tags",
      "tsx",
      "typescript",
    })
  end,
}
