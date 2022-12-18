vim.keymap.set("v", "v", "$h", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("n", "E", "ea", { noremap = true })

vim.keymap.set("n", "<leader>rp", "yiw<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("v", "<leader>rp", "y<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })

vim.keymap.set("n", "<leader>rc", "yiw<esc>:%s/<C-r>+//gn<cr>", { noremap = true })
vim.keymap.set("v", "<leader>rc", "y<esc>:%s/<C-r>+//gn<cr>", { noremap = true })

vim.keymap.set('n', '<leader>cd', ':cd %:p:h<cr>', { noremap = true })
