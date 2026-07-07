-- Open today's Obsidian daily note, carrying over any unfinished tasks from
-- the most recent previous daily note (which may be more than 1 day back).

local M = {}

-- Section headers whose "- [ ]" items get carried forward.
M.carry_sections = {
  "## Work TODO List",
  "## Personal TODO List",
}

-- How many days back to search for a previous daily note before giving up.
M.max_lookback_days = 30

---@return string[] lines, string path
local function read_lines(path)
  local lines = {}
  local file = io.open(path, "r")
  if not file then
    return lines, path
  end
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()
  return lines, path
end

local function write_lines(path, lines)
  local file = assert(io.open(path, "w"))
  file:write(table.concat(lines, "\n") .. "\n")
  file:close()
end

---Find the most recent existing daily note strictly before today.
---@return string? path
local function find_previous_note()
  local daily = require("obsidian.daily")
  local now = os.time()

  for offset = 1, M.max_lookback_days do
    local datetime = now - (offset * 3600 * 24)
    local path = daily.daily_note_path(datetime)
    if path:exists() then
      return tostring(path)
    end
  end

  return nil
end

---Pull unfinished "- [ ]" tasks out of `lines` for each section in
---`M.carry_sections`. Returns a map of section header -> list of task lines.
---@param lines string[]
---@return table<string, string[]>
local function extract_unfinished(lines)
  local carried = {}
  local current_section = nil

  for _, line in ipairs(lines) do
    local header = line:match("^(##%s+.+)$")
    if header then
      current_section = header
    elseif current_section and vim.tbl_contains(M.carry_sections, current_section) then
      -- Unfinished task: "- [ ] ..." (skip blank placeholder items)
      local task_text = line:match("^%s*%-%s*%[%s?%]%s*(.*)$")
      if task_text and task_text:match("%S") then
        carried[current_section] = carried[current_section] or {}
        table.insert(carried[current_section], "- [ ] " .. task_text)
      end
    end
  end

  return carried
end

---Insert carried-over tasks into `lines` directly under each matching
---section header, replacing the template's blank "- [ ]" placeholder line.
---@param lines string[]
---@param carried table<string, string[]>
---@return string[]
local function merge_carried(lines, carried)
  local result = {}
  local pending_section = nil

  for _, line in ipairs(lines) do
    local header = line:match("^(##%s+.+)$")
    local is_empty_placeholder = line:match("^%s*%-%s*%[%s?%]%s*$") ~= nil

    if header then
      table.insert(result, line)
      pending_section = carried[header] and header or nil
    elseif pending_section and line:match("^%s*$") then
      -- blank line right after the header: skip, we'll add our own spacing
    elseif pending_section and is_empty_placeholder then
      table.insert(result, "")
      for _, task in ipairs(carried[pending_section]) do
        table.insert(result, task)
      end
      pending_section = nil
    else
      table.insert(result, line)
    end
  end

  return result
end

---Open (creating if necessary) today's daily note, carrying over unfinished
---tasks from the most recent previous daily note.
function M.open_today_with_carryover()
  local daily = require("obsidian.daily")
  local today_path = daily.daily_note_path(os.time())

  if today_path:exists() then
    daily.today():open()
    return
  end

  local prev_path = find_previous_note()

  local note = daily.today()
  note:write()

  if prev_path then
    local prev_lines = read_lines(prev_path)
    local carried = extract_unfinished(prev_lines)

    if next(carried) ~= nil then
      local today_lines = read_lines(tostring(today_path))
      write_lines(tostring(today_path), merge_carried(today_lines, carried))

      local count = 0
      for _, tasks in pairs(carried) do
        count = count + #tasks
      end
      vim.notify(
        string.format("Carried over %d unfinished task(s) from %s", count, vim.fn.fnamemodify(prev_path, ":t:r")),
        vim.log.levels.INFO
      )
    end
  end

  note:open()
end

return M

