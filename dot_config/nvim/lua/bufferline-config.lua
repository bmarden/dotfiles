local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

vim.opt.termguicolors = true
bufferline.setup{
  options = {
    hover = {
      enabled = true,
      delay = 150,
      reveal = {'close'}
    }
  }
}
