---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path)
  return vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
end

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local function add(lang)
      if type(opts.ensure_installed) == "table" then
        table.insert(opts.ensure_installed, lang)
      end
    end
    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "bash",
      "css",
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gowork",
      "html",
      "html_tags",
      "markdown",
      "markdown_inline",
      "tsx",
      "typescript",
    })

    vim.filetype.add({
      extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
      filename = {
        ["vifmrc"] = "vim",
      },
      pattern = {
        [".*/waybar/config"] = "jsonc",
        [".*/mako/config"] = "dosini",
        [".*/hypr/.+%.conf"] = "hyprlang",
        ["%.env%.[%w_.-]+"] = "sh",
      },
    })

    add("git_config")
    if have("hypr") then
      add("hyprlang")
    end

    if have("fish") then
      add("fish")
    end

    if have("rofi") or have("wofi") then
      add("rasi")
    end
  end,
}
