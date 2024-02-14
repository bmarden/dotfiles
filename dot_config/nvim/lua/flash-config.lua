local status_ok, flash = pcall(require, "flash")
if not status_ok then
  return
end

local keys = {
  { "s",     mode = { "n", "x", "o" }, function() flash.jump() end,   desc = "Flash" },
  { "r",     mode = "o",               function() flash.remote() end, desc = "Remote Flash" },
  { "<c-s>", mode = { "c" },           function() flash.toggle() end, desc = "Toggle Flash Search" },
}

flash.setup({
  keys = keys
})
