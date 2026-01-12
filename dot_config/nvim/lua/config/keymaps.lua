-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Map jk to exit
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Paste from zero register to avoid pasting what was just deleted or removed
map({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste from zero register" })

-- Rename word under cursor
map("n", "<Leader>R", function()
  local word = vim.fn.expand("<cword>")
  vim.fn.feedkeys(
    ":%s/\\<" .. word .. "\\>//g" .. string.rep(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 2)
  )
end, { desc = "Rename word under cursor" })

-- Visual mode - rename selected text
map("v", "<Leader>R", function()
  -- Exit visual mode and get the selected text
  vim.cmd('normal! "vy')
  local selected_text = vim.fn.getreg("v")

  -- Escape special regex characters
  selected_text = vim.fn.escape(selected_text, "/\\[]^$.*~")

  -- Feed the substitute command
  vim.fn.feedkeys(
    ":%s/" .. selected_text .. "//g" .. string.rep(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 2)
  )
end, { desc = "Rename selected text" })

-- Shortcut to launch neogit
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })

-- By default, CTRL-U and CTRL-D scroll by half a screen (50% of the window height)
-- Scroll by 35% of the window height and keep the cursor centered
local scroll_percentage = 0.35
-- Scroll by a percentage of the window height and keep the cursor centered
map("n", "<C-d>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "jzz")
end, { noremap = true, silent = true })
map("n", "<C-u>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "kzz")
end, { noremap = true, silent = true })

-- Quit or exit neovim, easier than to do <leader>qq
map({ "n", "v", "i" }, "<M-q>", "<cmd>qa<cr>", { desc = "[P]Quit All" })
-- Close the current window

-- use gh to move to the beginning of the line in normal mode
-- use gl to move to the end of the line in normal mode
map({ "n", "v" }, "gh", "^", { desc = "[P]Go to the beginning line" })
map({ "n", "v" }, "gl", "$", { desc = "[P]go to the end of the line" })

-- In visual mode, after going to the end of the line, come back 1 character
map("v", "gl", "$h", { desc = "[P]Go to the end of the line" })

---@param command "today" |"dailies" | "search" | "tags" | "new_from_template" | "quick_switch"
---@param template_name? "new" | "meeting"
local run_obsidian_command = function(command, template_name)
  local cwd = vim.fn.getcwd()
  -- Change to vault directory before running commands to ensure templates are found
  local vault_path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ben-brain")

  local execute_command = function(cmd)
    vim.cmd("cd " .. vault_path)
    vim.cmd("Obsidian " .. cmd)
    vim.cmd("cd " .. cwd)
  end

  if template_name then
    vim.ui.input({ prompt = "Note Title: " }, function(title)
      if title and title ~= "" then
        execute_command(string.format("%s %s %s", command, title, template_name))
      else
        vim.notify("Aborted: No title provided", vim.log.levels.WARN)
      end
    end)
  else
    execute_command(command)
  end
end

-- Setup some keybindings for obsidian.nvim
map("n", "<leader>ot", function()
  run_obsidian_command("today")
end, { desc = "Open Obsidian Daily Note" })

map("n", "<leader>os", function()
  run_obsidian_command("search")
end, { desc = "Search in notes" })

map("n", "<leader>od", function()
  run_obsidian_command("dailies")
end, { desc = "Open dailies" })

map("n", "<leader>oq", function()
  run_obsidian_command("quick_switch")
end, { desc = "Quick switch notes" })

map("n", "<leader>om", function()
  run_obsidian_command("new_from_template", "meeting")
end, { desc = "Create Obsidian Meeting Note" })

map("n", "<leader>on", function()
  run_obsidian_command("new_from_template", "new")
end, { desc = "Create New Obsidian Note" })

map("n", "<leader>oT", function()
  run_obsidian_command("tags")
end, { desc = "Open Obsidian Tags" })

-- Neovim specific keybindings
if not vim.g.vscode then
  --  Set smart-splits keybindings
  map("n", "<D-j>", require("smart-splits").resize_down)
  map("n", "<D-h>", require("smart-splits").resize_left)
  map("n", "<D-k>", require("smart-splits").resize_up)
  map("n", "<D-l>", require("smart-splits").resize_right)
  -- moving between splits
  map("n", "<C-h>", require("smart-splits").move_cursor_left)
  map("n", "<C-j>", require("smart-splits").move_cursor_down)
  map("n", "<C-k>", require("smart-splits").move_cursor_up)
  map("n", "<C-l>", require("smart-splits").move_cursor_right)
  map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
  -- swapping buffers between windows
  map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
  map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
  map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
  map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

  -- Bufferline tab goto
  map("n", "<leader>1", "<CMD>BufferLineGoToBuffer 1<CR>", { silent = true })
  map("n", "<leader>2", "<CMD>BufferLineGoToBuffer 2<CR>", { silent = true })
  map("n", "<leader>3", "<CMD>BufferLineGoToBuffer 3<CR>", { silent = true })
  map("n", "<leader>4", "<CMD>BufferLineGoToBuffer 4<CR>", { silent = true })
  map("n", "<leader>5", "<CMD>BufferLineGoToBuffer 5<CR>", { silent = true })
  map("n", "<leader>6", "<CMD>BufferLineGoToBuffer 6<CR>", { silent = true })
  map("n", "<leader>7", "<CMD>BufferLineGoToBuffer 7<CR>", { silent = true })
  map("n", "<leader>8", "<CMD>BufferLineGoToBuffer 8<CR>", { silent = true })
  map("n", "<leader>9", "<CMD>BufferLineGoToBuffer 9<CR>", { silent = true })
end

-- VSCode specific keybindings
if vim.g.vscode then
  local vscode = require("vscode")
  -- map({ "n", "v" }, "<leader>/", function()
  --   vscode.action("editor.action.commentLine")
  -- end)
  -- VSCode specific keymaps
  -- Setup C-Left, C-Right, C-Up, C-Down to resize all panes (editor, terminal, explorer)
  map(
    "n",
    "<C-Left>",
    "<Cmd>call VSCodeNotify('workbench.action.decreaseViewSize')<CR>",
    { desc = "Decrease view size" }
  )
  map(
    "n",
    "<C-Right>",
    "<Cmd>call VSCodeNotify('workbench.action.increaseViewSize')<CR>",
    { desc = "Increase view size" }
  )
  map("n", "<C-Up>", "<Cmd>call VSCodeNotify('workbench.action.increaseViewSize')<CR>", { desc = "Increase view size" })
  map(
    "n",
    "<C-Down>",
    "<Cmd>call VSCodeNotify('workbench.action.decreaseViewSize')<CR>",
    { desc = "Decrease view size" }
  )
end
