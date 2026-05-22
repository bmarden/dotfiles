-- Grow/shrink visual selection by tree-sitter named siblings.
-- <Tab>   in visual: extend selection to the next named sibling
-- <S-Tab> in visual: shrink selection from the trailing named sibling
-- <M-Tab> in visual: extend selection to the previous named sibling

local function get_visual_range()
  local anchor = vim.fn.getpos("v")
  local cursor = vim.fn.getpos(".")
  local start_row, start_col = anchor[2] - 1, anchor[3] - 1
  local end_row, end_col = cursor[2] - 1, cursor[3] - 1
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, start_col, end_row, end_col = end_row, end_col, start_row, start_col
  end
  return start_row, start_col, end_row, end_col
end

local function set_visual_range(start_row, start_col, end_row, end_col)
  -- Exit visual first so `normal! v` enters fresh visual instead of toggling off.
  local mode = vim.api.nvim_get_mode().mode
  if mode:match("^[vV\22]") then
    vim.cmd("normal! \27") -- <Esc>
  end
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
  vim.cmd("normal! v")
  vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
end

-- Smallest named node fully containing the given range.
local function smallest_named_node_covering(start_row, start_col, end_row, end_col)
  local ok, node = pcall(vim.treesitter.get_node, {
    pos = { start_row, start_col },
    ignore_injections = false,
  })
  if not ok or not node then
    return nil
  end
  while node do
    local node_start_row, node_start_col, node_end_row, node_end_col = node:range()
    local starts_at_or_before = (node_start_row < start_row)
      or (node_start_row == start_row and node_start_col <= start_col)
    local ends_at_or_after = (node_end_row > end_row)
      or (node_end_row == end_row and node_end_col >= end_col)
    if starts_at_or_before and ends_at_or_after and node:named() then
      return node
    end
    node = node:parent()
  end
  return nil
end

-- Walk down to the deepest named descendant whose start position matches.
local function deepest_named_starting_at(node, target_row, target_col)
  local current = node
  while current do
    local descendant
    for child in current:iter_children() do
      if child:named() then
        local child_start_row, child_start_col = child:range()
        if child_start_row == target_row and child_start_col == target_col then
          descendant = child
          break
        end
      end
    end
    if not descendant then
      return current
    end
    current = descendant
  end
  return node
end

-- Walk down to the deepest named descendant whose end position matches.
local function deepest_named_ending_at(node, target_row, target_col)
  local current = node
  while current do
    local descendant
    for child in current:iter_children() do
      if child:named() then
        local _, _, child_end_row, child_end_col = child:range()
        if child_end_row == target_row and child_end_col == target_col then
          descendant = child
        end
      end
    end
    if not descendant then
      return current
    end
    current = descendant
  end
  return node
end

local function grow_forward()
  local sel_start_row, sel_start_col, sel_end_row, sel_end_col = get_visual_range()
  -- Visual selection end column is inclusive; tree-sitter end is exclusive.
  local ts_end_col = sel_end_col + 1
  local covering = smallest_named_node_covering(sel_start_row, sel_start_col, sel_end_row, ts_end_col)
  if not covering then
    return
  end
  local tail = deepest_named_ending_at(covering, sel_end_row, ts_end_col)
  local next_sibling = tail:next_named_sibling()
  if not next_sibling then
    return
  end
  local _, _, next_end_row, next_end_col = next_sibling:range()
  set_visual_range(sel_start_row, sel_start_col, next_end_row, math.max(next_end_col - 1, 0))
end

local function grow_backward()
  local sel_start_row, sel_start_col, sel_end_row, sel_end_col = get_visual_range()
  local ts_end_col = sel_end_col + 1
  local covering = smallest_named_node_covering(sel_start_row, sel_start_col, sel_end_row, ts_end_col)
  if not covering then
    return
  end
  local head = deepest_named_starting_at(covering, sel_start_row, sel_start_col)
  local prev_sibling = head:prev_named_sibling()
  if not prev_sibling then
    return
  end
  local prev_start_row, prev_start_col = prev_sibling:range()
  set_visual_range(prev_start_row, prev_start_col, sel_end_row, sel_end_col)
end

local function shrink_from_tail()
  local sel_start_row, sel_start_col, sel_end_row, sel_end_col = get_visual_range()
  local ts_end_col = sel_end_col + 1
  local covering = smallest_named_node_covering(sel_start_row, sel_start_col, sel_end_row, ts_end_col)
  if not covering then
    return
  end
  local tail = deepest_named_ending_at(covering, sel_end_row, ts_end_col)
  local prev_sibling = tail:prev_named_sibling()
  if not prev_sibling then
    return
  end
  local _, _, prev_end_row, prev_end_col = prev_sibling:range()
  set_visual_range(sel_start_row, sel_start_col, prev_end_row, math.max(prev_end_col - 1, 0))
end

return {
  "nvim-treesitter/nvim-treesitter",
  keys = {
    { "<Tab>", grow_forward, mode = "x", desc = "TS: grow to next sibling" },
    { "<S-Tab>", shrink_from_tail, mode = "x", desc = "TS: shrink from tail sibling" },
    { "<M-Tab>", grow_backward, mode = "x", desc = "TS: grow to prev sibling" },
  },
}
