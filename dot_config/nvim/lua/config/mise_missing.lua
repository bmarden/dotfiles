-- :MiseMissing[!] lists LSP servers, formatters and linters whose binary isn't on PATH and suggests
-- nvim-tools.toml entries for them. Only depends on core APIs (conform, nvim-lint and mason-registry
-- are optional) so it can be dropped into a non-LazyVim config.
local M = {}

local purl_backends = { npm = 'npm', pypi = 'pipx', golang = 'go', cargo = 'cargo', github = 'github', gem = 'gem' }

---@param purl string e.g. pkg:golang/github.com/go-delve/delve@v1.25.0#cmd/dlv
---@return string?
local function purl_to_mise(purl)
  local kind, rest = purl:match('^pkg:(%w+)/(.+)$')
  local backend = purl_backends[kind]
  if not backend then
    return nil
  end
  local subpath = rest:match('#(.+)$')
  rest = rest:gsub('#.*$', ''):gsub('%?.*$', '')
  rest = rest:gsub('%%(%x%x)', function(h)
    return string.char(tonumber(h, 16))
  end)
  local name = rest:match('^(.+)@[^@/]*$') or rest
  if subpath and backend == 'go' then
    name = name .. '/' .. subpath
  end
  return backend .. ':' .. name
end

---@class MiseMissing.Index
---@field by_bin table<string, table> mason spec per binary name
---@field by_lsp table<string, table> mason spec per lspconfig server name

---@return MiseMissing.Index
local function mason_index()
  local index = { by_bin = {}, by_lsp = {} }
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    return index
  end
  for _, spec in ipairs(registry.get_all_package_specs()) do
    for bin in pairs(spec.bin or {}) do
      index.by_bin[bin] = index.by_bin[bin] or spec
    end
    if spec.neovim and spec.neovim.lspconfig then
      index.by_lsp[spec.neovim.lspconfig] = spec
    end
  end
  return index
end

---@param spec table mason package spec
---@param short_names table<string, boolean> tools in the mise registry
---@return string?
local function mise_tool(spec, short_names)
  return short_names[spec.name] and spec.name or purl_to_mise(spec.source.id)
end

---@param list string[]?
---@param value string
local function contains(list, value)
  return vim.tbl_contains(list or {}, value)
end

---@param cmd string|string[]|function|nil
---@return string?
local function bin_of(cmd)
  if type(cmd) == 'function' then
    local ok, ret = pcall(cmd)
    cmd = ok and ret or nil
  end
  if type(cmd) == 'table' then
    cmd = cmd[1]
  end
  return type(cmd) == 'string' and cmd or nil
end

---@param bufnr integer
---@param all boolean
---@param index MiseMissing.Index
---@param add fun(bin: string?, source: string)
local function collect_lsp(bufnr, all, index, add)
  local ft = vim.bo[bufnr].filetype
  local names = vim.tbl_keys(vim.lsp.config._configs)
  for _, f in ipairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
    names[#names + 1] = vim.fn.fnamemodify(f, ':t:r')
  end
  for _, name in ipairs(vim.fn.uniq(vim.fn.sort(names))) do
    if name ~= '*' and vim.lsp.is_enabled(name) then
      local config = vim.lsp.config[name] or {}
      if all or contains(config.filetypes, ft) then
        local bin = type(config.cmd) == 'table' and config.cmd[1] or nil
        -- lspconfig uses cmd functions to prefer a project-local node_modules binary, so the
        -- global binary name has to come from Mason's server -> package mapping
        local spec = index.by_lsp[name]
        if not bin and spec then
          bin = next(spec.bin or {})
        end
        add(bin, 'lsp ' .. name)
      end
    end
  end
end

---@param bufnr integer
---@param all boolean
---@param add fun(bin: string?, source: string)
local function collect_formatters(bufnr, all, add)
  local ok, conform = pcall(require, 'conform')
  if not ok then
    return
  end
  local names = {}
  if all then
    for _, fmts in pairs(conform.formatters_by_ft) do
      if type(fmts) == 'function' then
        fmts = fmts(bufnr)
      end
      vim.list_extend(names, fmts)
    end
  else
    names = conform.list_formatters_for_buffer(bufnr)
  end
  for _, name in ipairs(vim.fn.uniq(vim.fn.sort(names))) do
    local config = conform.get_formatter_config(name, bufnr)
    -- Lua formatters (injected, trim_whitespace, ...) have no binary
    if config and not config.format then
      add(conform.get_formatter_info(name, bufnr).command, 'formatter ' .. name)
    end
  end
end

---@param bufnr integer
---@param all boolean
---@param add fun(bin: string?, source: string)
local function collect_linters(bufnr, all, add)
  local ok, lint = pcall(require, 'lint')
  if not ok then
    return
  end
  local names = {}
  for ft, linters in pairs(lint.linters_by_ft) do
    if all or contains(vim.split(vim.bo[bufnr].filetype, '.', { plain = true }), ft) then
      vim.list_extend(names, linters)
    end
  end
  for _, name in ipairs(vim.fn.uniq(vim.fn.sort(names))) do
    local linter = lint.linters[name]
    if type(linter) == 'function' then
      linter = linter()
    end
    add(linter and bin_of(linter.cmd), 'linter ' .. name)
  end
end

---@param all boolean check every configured filetype instead of the current buffer's
function M.run(all)
  local bufnr = vim.api.nvim_get_current_buf()
  local index = mason_index()
  local missing = {} ---@type table<string, string[]>
  local unchecked = {} ---@type string[]
  local function add(bin, source)
    if not bin then
      table.insert(unchecked, '# ' .. source)
    elseif vim.fn.executable(bin) == 0 then
      missing[bin] = missing[bin] or {}
      table.insert(missing[bin], source)
    end
  end
  collect_lsp(bufnr, all, index, add)
  collect_formatters(bufnr, all, add)
  collect_linters(bufnr, all, add)

  if vim.tbl_isempty(missing) and #unchecked == 0 then
    vim.notify('No missing tools', vim.log.levels.INFO, { title = 'MiseMissing' })
    return
  end

  local short_names = {}
  local res = vim.system({ 'mise', 'registry' }, { text = true }):wait()
  for line in vim.gsplit(res.stdout or '', '\n', { trimempty = true }) do
    short_names[line:match('^(%S+)')] = true
  end

  local tools, unknown = {}, {}
  for bin, sources in pairs(missing) do
    local spec = index.by_bin[vim.fs.basename(bin)]
    local tool = spec and mise_tool(spec, short_names)
    local note = ('# %s (%s)'):format(bin, table.concat(sources, ', '))
    if tool then
      tools[tool] = tools[tool] or {}
      table.insert(tools[tool], note)
    else
      table.insert(unknown, note)
    end
  end

  local lines = {}
  for _, tool in ipairs(vim.fn.sort(vim.tbl_keys(tools))) do
    vim.list_extend(lines, vim.fn.sort(tools[tool]))
    lines[#lines + 1] = ('"%s" = "latest"'):format(tool)
  end
  if #unknown > 0 then
    vim.list_extend(lines, { '', '# No Mason package found, check `mise registry <name>`:' })
    vim.list_extend(lines, vim.fn.sort(unknown))
  end
  if #unchecked > 0 then
    vim.list_extend(lines, { '', '# Binary unknown (cmd is a function), check `:checkhealth vim.lsp`:' })
    vim.list_extend(lines, vim.fn.sort(unchecked))
  end

  vim.cmd('botright new')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.filetype = 'toml'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.setup()
  vim.api.nvim_create_user_command('MiseMissing', function(cmd)
    M.run(cmd.bang)
  end, { bang = true, desc = 'List tools missing from PATH (! for all filetypes)' })
end

return M
