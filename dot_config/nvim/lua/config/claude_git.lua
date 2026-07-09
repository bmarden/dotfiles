-- AI commit messages, PR titles, and PR summaries via the `claude` CLI
-- (headless `-p` mode). The diff is piped over stdin so claude never runs git
-- itself (no tool-permission prompt, deterministic). Calls are async.

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

local PR_SUMMARY_TEMPLATE = [[
# What does this PR do?

## Related Tickets

-

## Related PRs

- #

## Test Instructions

1.

## Screenshots or GIFs (if applicable)
]]

local PR_SUMMARY_PROMPT = table.concat({
  "Summarize the key changes in this branch diff as a PR description. Use bullet points when it will help readability.",
  "Fill in this markdown template, keeping its headings exactly. Leave the",
  "Related Tickets, Related PRs, and Screenshots sections as-is if you can't",
  "infer them. Be concise, not verbose. Output markdown only — no preamble, no",
  "code fences wrapping the whole thing.\n\nTEMPLATE:\n" .. PR_SUMMARY_TEMPLATE,
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

---Paste text like vim's `p`: over the selection in visual mode, at the cursor
---otherwise. Also copies it to the + register.
---@param text string
local function put(text)
  vim.fn.setreg("+", text)
  local mode = vim.api.nvim_get_mode().mode
  if mode:match("^[vV\22]") then
    -- Replace the active selection: yank it into a scratch register with `p`.
    vim.cmd('normal! "+p')
  else
    vim.api.nvim_put(vim.split(text, "\n"), "c", true, true)
  end
end

---Generate a commit message from the staged diff and prepend it into `buf`.
---@param buf integer buffer to write into (the gitcommit buffer)
local function commit_message(buf)
  generate({ "git", "diff", "--cached" }, COMMIT_PROMPT, function(msg)
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, vim.split(msg, "\n"))
  end)
end

---Generate a PR title from the branch diff vs the base branch, insert at cursor.
local function pr_title()
  generate({ "git", "diff", M.base_branch .. "...HEAD" }, PR_TITLE_PROMPT, function(title)
    put(title)
    vim.notify("PR title yanked to clipboard: " .. title, vim.log.levels.INFO)
  end)
end

---Context-aware generator bound to one key:
--- in a gitcommit buffer -> commit message; otherwise -> PR title.
function M.smart_msg()
  if vim.bo.filetype == "gitcommit" then
    commit_message(0)
  else
    pr_title()
  end
end

---Generate a PR summary from the branch diff vs base, insert at cursor.
function M.pr_summary()
  generate({ "git", "diff", M.base_branch .. "...HEAD" }, PR_SUMMARY_PROMPT, function(summary)
    put(summary)
    vim.notify("PR summary inserted", vim.log.levels.INFO)
  end)
end

return M
