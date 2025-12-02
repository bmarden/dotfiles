local M = {}

local function fetch_github_repo_id(repo_name, token, org)
  local cmd = {
    "curl",
    "-H",
    "Authorization: Bearer " .. token,
    "-H",
    "User-Agent: Neovim",
    "https://api.github.com/repos/" .. org .. "/" .. repo_name,
  }

  local result = vim.system(cmd):wait()
  if not result or not result.stdout then
    print("No result from GitHub API")
    return {}
  end

  local raw_json = result.stdout
  if raw_json == "" then
    print("Empty JSON from GitHub API")
    return {}
  end

  local ok, data = pcall(vim.json.decode, raw_json)
  if not ok or type(data) ~= "table" then
    -- print("Failed to decode JSON from GitHub API")
    return {}
  end

  return data.id
end

function M.get_github_repo_config()
  if vim.env.GH_ACTIONS_PAT == nil then
    return nil
  end

  -- Get the current git directory
  local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return nil
  end

  -- Get remote URL and parse owner/name
  local remote_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
  if vim.v.shell_error ~= 0 then
    return nil
  end

  -- Parse GitHub owner and repo name from URL
  local owner, name = remote_url:match("github%.com[:/](.+)/(.+)%.git")
  if not owner or not name then
    owner, name = remote_url:match("github%.com[:/](.+)/(.+)$")
  end

  if not owner or not name then
    return nil
  end

  local repo_id = fetch_github_repo_id(name, vim.env.GH_ACTIONS_PAT, owner)

  -- You could add logic here to fetch repo ID via GitHub API
  -- or maintain a mapping of known repos
  return {
    id = repo_id,
    owner = owner,
    name = name,
    workspaceUri = "file://" .. git_dir,
    organizationOwned = owner:lower() ~= "bmarden",
  }
end

return M
