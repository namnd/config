vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true

vim.keymap.set("n", "<leader>tt", ":Dispatch zig test %<cr>")
vim.keymap.set("n", "<leader>x", ":Dispatch zig run %<cr>")

local group = vim.api.nvim_create_augroup("ZigGroup", { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = function ()
    vim.lsp.buf.formatting_sync({}, 1000)
  end
})
