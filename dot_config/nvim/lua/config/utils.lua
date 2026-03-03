local M = {}

---@param repo_name string
---@param token string
---@param org string
---@param callback fun(repo_id: number|nil)
local function fetch_github_repo_id(repo_name, token, org, callback)
  local cmd = {
    "curl",
    "-s",
    "-H",
    "Authorization: Bearer " .. token,
    "-H",
    "User-Agent: Neovim",
    "https://api.github.com/repos/" .. org .. "/" .. repo_name,
  }

  vim.system(cmd, {}, function(result)
    if not result or not result.stdout or result.stdout == "" then
      callback(nil)
      return
    end

    local ok, data = pcall(vim.json.decode, result.stdout)
    if not ok or type(data) ~= "table" then
      callback(nil)
      return
    end

    callback(data.id)
  end)
end

---@param callback fun(config: table|nil)
function M.get_github_repo_config(callback)
  if vim.env.GH_ACTIONS_PAT == nil then
    callback(nil)
    return
  end

  local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    callback(nil)
    return
  end

  local remote_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
  if vim.v.shell_error ~= 0 then
    callback(nil)
    return
  end

  local owner, name = remote_url:match("github%.com[:/](.+)/(.+)%.git")
  if not owner or not name then
    owner, name = remote_url:match("github%.com[:/](.+)/(.+)$")
  end

  if not owner or not name then
    callback(nil)
    return
  end

  fetch_github_repo_id(name, vim.env.GH_ACTIONS_PAT, owner, function(repo_id)
    vim.schedule(function()
      callback({
        id = repo_id,
        owner = owner,
        name = name,
        workspaceUri = "file://" .. git_dir,
        organizationOwned = owner:lower() ~= "bmarden",
      })
    end)
  end)
end

return M
