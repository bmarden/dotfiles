local m_opts = { noremap = true, silent = true }

-- Shorten function name
local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>", m_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- insert --
-- press jk fast to exit insert mode
map("i", "jk", "<esc>", m_opts) -- Insert mode -> jk -> Normal mode
map("i", "kj", "<esc>", m_opts) -- Insert mode -> kj -> Normal mode

-- visual --
-- stay in indent mode
map("v", ">", ">gv", m_opts) -- Left Indentation
map("v", "<", "<gv", m_opts) -- Right Indentation

map('n', '<leader>n', ':noh<CR>', { noremap = true, silent = true })

map('n', '<leader>/', ':%s//g<Left><Left>', { noremap = true, silent = true })


if vim.g.vscode then
  local vscode = require("vscode-neovim")
  local function vscode_map(mode, key, action)
    local default_opts = { noremap = true, silent = true }
    map(mode, key, '', { callback = function() vscode.call(action) end, noremap = true, silent = true })
  end

  -- Navigating between windows
  vscode_map({ 'n', 'x' }, '<C-j>', 'workbench.action.navigateDown')
  vscode_map({ 'n', 'x' }, '<C-k>', 'workbench.action.navigateUp')
  vscode_map({ 'n', 'x' }, '<C-h>', 'workbench.action.navigateLeft')
  vscode_map({ 'n', 'x' }, '<C-l>', 'workbench.action.navigateRight')
  -- Leader shortcuts
  vscode_map('n', '<leader>r', 'editor.action.rename')
  vscode_map('n', 'ga', 'editor.action.marker.next')
  vscode_map('n', 'gA', 'editor.action.marker.prev')
  vscode_map('n', '<leader>[', 'editor.fold')
  vscode_map('n', '<leader>]', 'editor.unfold')
  vscode_map('n', '<leader>e', 'workbench.action.toggleSidebarVisibility')
  vscode_map('n', '<leader>h', 'workbench.action.splitEditorDown')
  vscode_map('n', '<leader>v', 'workbench.action.splitEditorRight')
  vscode_map('n', '<leader>w', 'whichkey.show')

  -- Go to references
  vscode_map('n', 'gr', 'references-view.findReferences')
  vscode_map('n', 'gt', 'editor.action.goToTypeDefinition')
  vscode_map('n', 'gi', 'editor.action.goToImplementation')

  -- Use ? to search for the word under the cursor
  map('n', '?<CR>', '',
    {
      callback = function()
        vscode.action('workbench.action.findInFiles',
          { args = { { query = vim.fn.expand('<cword>') } } })
      end,
      noremap = true,
      silent = true
    }
  )

  local function moveCursor(direction)
    if (vim.fn.reg_recording() == '' and vim.fn.reg_executing() == '') then
      return ('g' .. direction)
    else
      return direction
    end
  end

  -- Ensures that moving the cursor over wrapped lines works correctly
  vim.keymap.set('n', 'k', function()
    return moveCursor('k')
  end, { expr = true, remap = true })
  vim.keymap.set('n', 'j', function()
    return moveCursor('j')
  end, { expr = true, remap = true })
else
  -- Normal --
  -- Better window navigation
  map("n", "<C-h>", "<C-w>h", m_opts) -- left window
  map("n", "<C-k>", "<C-w>k", m_opts) -- up window
  map("n", "<C-j>", "<C-w>j", m_opts) -- down window
  map("n", "<C-l>", "<C-w>l", m_opts) -- right window

  -- Resize with arrows when using multiple windows
  map("n", "<C-Up>", ":resize -2<CR>", m_opts)
  map("n", "<c-down>", ":resize +2<cr>", m_opts)
  map("n", "<c-right>", ":vertical resize -2<cr>", m_opts)
  map("n", "<c-left>", ":vertical resize +2<cr>", m_opts)

  -- navigate buffers
  map("n", "<tab>", ":bnext<cr>", m_opts)          -- Next Tab
  map("n", "<s-tab>", ":bprevious<cr>", m_opts)    -- Previous tab
  map("n", "<leader>h", ":nohlsearch<cr>", m_opts) -- No highlight search

  -- Shortcuts for splitting windows
  map("n", "<leader>h", ":split<CR>", m_opts)
  map("n", "<leader>v", ":vsplit<CR>", m_opts)
end
