local has_cmp, cmp = pcall(require, "cmp")

if not has_cmp then
  return
end

cmp.setup.buffer({
  sources = {
    { name = 'vim-dadbod-completion' },
  },
})

vim.wo.foldenable = false
