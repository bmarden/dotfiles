---@diagnostic disable: assign-type-mismatch
local wezterm = require('wezterm') ---@type Wezterm
local act = wezterm.action

local module = {}

---@param tab MuxTab
---@return table[]
local function pane_geometry(tab)
  local panes = {}
  for _, p in ipairs(tab:panes_with_info()) do
    if not p.is_zoomed then
      table.insert(panes, p)
    end
  end
  return panes
end

--- Equivalent of kitty's `layout_action bias N`: resize the active pane so it
--- occupies N percent of the space shared with its neighbor along the split
--- axis. WezTerm only exposes relative resizes, so derive the cell delta from
--- current geometry.
---@param percent number
local function bias(percent)
  return wezterm.action_callback(function(win, pane)
    local tab = win:active_tab()
    local panes = pane_geometry(tab)
    if #panes < 2 then
      return
    end

    local current
    for _, p in ipairs(panes) do
      if p.pane:pane_id() == pane:pane_id() then
        current = p
      end
    end
    if not current then
      return
    end

    -- Only the active pane's immediate split siblings matter: they touch it
    -- along the split axis and cover the same extent on the cross axis. Merely
    -- overlapping panes (e.g. a full-width pane above a split row) belong to an
    -- outer split and must not be mistaken for siblings, or bias would resize
    -- the wrong divider.
    local function span(vertical)
      local cur_start = vertical and current.top or current.left
      local cur_size = vertical and current.height or current.width
      local cur_cross = vertical and current.left or current.top
      local cur_extent = vertical and current.width or current.height

      local lo, hi = cur_start, cur_start + cur_size
      local others = 0
      for _, p in ipairs(panes) do
        if p.pane:pane_id() ~= current.pane:pane_id() then
          local start = vertical and p.top or p.left
          local size = vertical and p.height or p.width
          local cross = vertical and p.left or p.top
          local extent = vertical and p.width or p.height

          -- Same cross-axis band (within a cell of slack for borders) and
          -- adjacent along the split axis.
          local aligned = math.abs(cross - cur_cross) <= 1 and math.abs(extent - cur_extent) <= 1
          local touching = math.abs(start - (cur_start + cur_size)) <= 1 or math.abs(cur_start - (start + size)) <= 1

          if aligned and touching then
            lo = math.min(lo, start)
            hi = math.max(hi, start + size)
            others = others + 1
          end
        end
      end

      if others > 0 then
        return lo, hi - lo, others
      end

      -- No single pane matches the active one's cross-axis extent, so the
      -- sibling is a nested group (e.g. a full-width pane above a split row).
      -- Treat every pane touching the shared edge as that group.
      for _, p in ipairs(panes) do
        if p.pane:pane_id() ~= current.pane:pane_id() then
          local start = vertical and p.top or p.left
          local size = vertical and p.height or p.width
          local cross = vertical and p.left or p.top
          local extent = vertical and p.width or p.height

          local within = cross >= cur_cross - 1 and cross + extent <= cur_cross + cur_extent + 1
          local touching = math.abs(start - (cur_start + cur_size)) <= 1 or math.abs(cur_start - (start + size)) <= 1

          if within and touching then
            lo = math.min(lo, start)
            hi = math.max(hi, start + size)
            others = others + 1
          end
        end
      end
      return lo, hi - lo, others
    end

    -- Resize along whichever axis the active pane actually has a sibling on.
    -- With siblings on both, vertical matches kitty's stacked-layout default.
    local v_lo, v_total, v_others = span(true)
    local h_lo, h_total, h_others = span(false)
    local vertical = v_others > 0
    local lo = vertical and v_lo or h_lo
    local total = vertical and v_total or h_total
    if (vertical and v_others or h_others) == 0 or total <= 0 then
      return
    end

    -- kitty's bias sizes the *first* pane in the split, so a pane on the far
    -- side of the divider gets the complement.
    local start = vertical and current.top or current.left
    local size = vertical and current.height or current.width
    local first = start <= lo
    local fraction = first and percent or (100 - percent)
    local delta = math.floor(total * fraction / 100 + 0.5) - size
    if delta == 0 then
      return
    end

    -- AdjustPaneSize moves the divider in the given direction rather than
    -- growing the active pane, so which way to push depends on the side the
    -- active pane sits on: the first pane grows by pushing away from its own
    -- edge, the second by pulling the divider back toward it.
    local grow, shrink
    if vertical then
      grow, shrink = 'Down', 'Up'
    else
      grow, shrink = 'Right', 'Left'
    end
    if not first then
      grow, shrink = shrink, grow
    end
    local direction = delta > 0 and grow or shrink
    win:perform_action(act.AdjustPaneSize({ direction, math.abs(delta) }), pane)
  end)
end

---@param config Config
function module.apply_to_config(config)
  config.keys = config.keys or {}

  table.insert(config.keys, { key = '.', mods = 'CTRL', action = bias(25) })
  table.insert(config.keys, { key = ',', mods = 'CTRL', action = bias(50) })
end

return module
