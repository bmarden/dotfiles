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
      "markdown",
      "markdown_inline",
      "tsx",
      "typescript",
    })
  end,
}
