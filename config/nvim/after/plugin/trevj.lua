local has_trevj, trevj = pcall(require, "trevj")

if not has_trevj then
  return
end

trevj.setup()
vim.keymap.set("n", '<leader>K', ":lua require('trevj').format_at_cursor()<cr>", { noremap = true })
