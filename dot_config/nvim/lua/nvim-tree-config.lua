local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- local api_status_ok, tree_api = pcall(require, "nvim-tree.api")
-- if not api_status_ok then
--   return
-- end

-- local function my_on_attach(bufnr)
--   local function opts(desc)
--     return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--   end
-- 
--   -- default mappings
--   tree_api.config.mappings.default_on_attach(bufnr)
-- 
--   -- custom mappings
--   vim.keymap.set('n', '<C-t>', tree_api.tree.change_root_to_parent,        opts('Up'))
--   vim.keymap.set('n', '?',     tree_api.tree.toggle_help,                  opts('Help'))
--   -- vim.keymap.set('n', 'h',     tree_api.tree.close_node,                   opts('Close node'))
-- end

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
 -- These icons are visible when you install web-devicons
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  -- on_attach = my_on_attach,
  view = {
    width = 30,
    side = "left",
  },
}
