-- AI commit messages + PR titles via the `claude` CLI (headless `-p` mode).
-- Diff is piped over stdin so claude never runs git itself (no tool-permission
-- prompt, deterministic). Calls are async via vim.system.

local M = {}

M.model = "claude-haiku-4-5-20251001"
M.base_branch = "main"

local COMMIT_PROMPT = table.concat({
  "Output ONLY a Conventional Commits message for this staged git diff.",
  "Format: <type>(<scope>): <subject>, subject imperative and <=50 chars.",
  "Add a body only if the why isn't obvious (72-char wrapped lines).",
  "No prose, no backticks, no code fences.",
}, " ")

local PR_TITLE_PROMPT = table.concat({
  "Output ONLY a single-line Conventional Commits PR title for this branch diff:",
  "<type>(<scope>): <subject>, imperative, <=70 chars.",
  "No body, no prose, no quotes, no backticks.",
}, " ")

---Run `<diff_cmd> | claude -p <prompt>` async, return trimmed stdout via callback.
---@param diff_cmd string[] git command producing the diff
---@param prompt string
---@param on_done fun(text: string)
local function generate(diff_cmd, prompt, on_done)
  local diff = vim.fn.system(diff_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("git diff failed: " .. diff, vim.log.levels.ERROR)
    return
  end
  if diff:match("^%s*$") then
    vim.notify("No changes to summarize", vim.log.levels.WARN)
    return
  end

  vim.notify("Generating with claude…", vim.log.levels.INFO)
  vim.system({ "claude", "-p", "--model", M.model, prompt }, { stdin = diff, text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify("claude failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
        return
      end
      local text = (result.stdout or ""):gsub("%s+$", "")
      -- Strip a wrapping ```fence``` if the model added one anyway.
      text = text:gsub("^```%w*\n?", ""):gsub("\n?```$", "")
      if text == "" then
        vim.notify("claude returned empty output", vim.log.levels.WARN)
        return
      end
      on_done(text)
    end)
  end)
end

---Generate a commit message from the staged diff and prepend it into `buf`.
---@param buf integer buffer to write into (the gitcommit buffer)
function M.commit_message(buf)
  generate({ "git", "diff", "--cached" }, COMMIT_PROMPT, function(msg)
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, vim.split(msg, "\n"))
  end)
end

---Generate a PR title from the branch diff vs the base branch.
---Yanks to the + register and inserts at cursor.
function M.pr_title()
  generate({ "git", "diff", M.base_branch .. "...HEAD" }, PR_TITLE_PROMPT, function(title)
    vim.fn.setreg("+", title)
    vim.api.nvim_put({ title }, "c", true, true)
    vim.notify("PR title yanked to clipboard: " .. title, vim.log.levels.INFO)
  end)
end

return M
