-- remap
vim.keymap.set("v", "<leader>rf", ':lua require("namnd.refactoring").extract_variable()<cr>', { noremap = true })
vim.keymap.set("n", "<leader>rf", ':%s/<C-r>a//gc<left><left><left>', { noremap = true })

-- navigation
vim.keymap.set('n', '<leader>1', ':Dispatch ', { noremap = true })
vim.keymap.set('n', '<leader>2', ':ToggleQuickFix<cr>', { noremap = true })
vim.keymap.set('n', '<<', ':colder<cr>', { noremap = true })
vim.keymap.set('n', '>>', ':cnewer<cr>', { noremap = true })
