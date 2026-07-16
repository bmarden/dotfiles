-- Trace where a notification message originates.
--
-- Some notifications don't say which file emitted them. Notably Neovim core's
-- `watch.watch: ENOENT` (vim/_watch.lua) is emitted via `vim.notify_once`, NOT
-- `vim.notify` -- so both must be hooked to catch it.
--
-- On arm, this wraps the *current* `vim.notify` and `vim.notify_once` (captured
-- at arm time, so it sits on top of whatever noice/snacks installed). When a
-- message matches the given Lua pattern, it captures the full stack trace down
-- to the emitting file:line, shows it, then restores both originals so nothing
-- lingers.
--
-- Usage:
--   :NotifyTrace watch%.watch     -- arm for the next message matching a pattern
--   :NotifyTrace                  -- arm for the next notification of any kind
--   <leader>uN                    -- prompt for a pattern, then arm

local M = {}

local armed = false

---@param pattern string? Lua pattern to match against the message (nil = any)
function M.arm(pattern)
  if armed then
    M.disarm()
  end
  armed = true

  local orig_notify = vim.notify
  local orig_notify_once = vim.notify_once

  local function restore()
    vim.notify = orig_notify
    vim.notify_once = orig_notify_once
    armed = false
  end
  M.disarm = restore

  local function make_hook(passthrough)
    return function(msg, level, opts)
      if armed and type(msg) == "string" and (pattern == nil or msg:match(pattern)) then
        restore()
        local trace = debug.traceback("notify-source caught: " .. msg, 2)
        vim.schedule(function()
          orig_notify(trace, vim.log.levels.WARN, { title = "NotifyTrace" })
        end)
        return
      end
      return passthrough(msg, level, opts)
    end
  end

  vim.notify = make_hook(orig_notify)
  vim.notify_once = make_hook(orig_notify_once)

  local armed_msg = ("NotifyTrace armed%s"):format(
    pattern and (" for /" .. pattern .. "/") or " (next notification)"
  )
  -- Use both print() and notify: print() reaches :messages even if a notifier
  -- UI swallows the toast, so you always get confirmation it armed.
  print(armed_msg)
  orig_notify(armed_msg, vim.log.levels.INFO)
end

-- Replaced with a real restore fn while armed; no-op otherwise.
function M.disarm() end

function M.setup()
  vim.api.nvim_create_user_command("NotifyTrace", function(cmd)
    M.arm(cmd.args ~= "" and cmd.args or nil)
  end, {
    nargs = "?",
    desc = "Trace the source of the next matching notification",
  })

  vim.api.nvim_create_user_command("NotifyTraceOff", function()
    M.disarm()
    print("NotifyTrace disarmed")
  end, { desc = "Cancel a pending NotifyTrace" })

  vim.keymap.set("n", "<leader>uN", function()
    vim.ui.input({ prompt = "NotifyTrace pattern (blank = any): " }, function(input)
      if input ~= nil then
        M.arm(input ~= "" and input or nil)
      end
    end)
  end, { desc = "Trace source of next notification" })
end

return M