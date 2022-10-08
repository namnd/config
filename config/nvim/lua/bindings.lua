-- remap
vim.keymap.set("v", "v", "$h", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("n", "E", "ea", { noremap = true })
vim.keymap.set("n", "<leader>rp", "yiw<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("n", "<leader>rc", "yiw<esc>:%s/<C-r>+//gn<cr>", { noremap = true })
vim.keymap.set("v", "<leader>rp", "y<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("v", "<leader>rc", "y<esc>:%s/<C-r>+//gn<cr>", { noremap = true })
vim.keymap.set("v", "<leader>rf", ':lua require("namnd.refactoring").extract_variable()<cr>', { noremap = true })
vim.keymap.set("n", "<leader>rf", ':%s/<C-r>a//gc<left><left><left>', { noremap = true })
vim.keymap.set("n", "<leader>yy", ':let @+=expand("%")<cr>', { noremap = true })

-- git
vim.keymap.set('n', '<leader>gg', ':tab G<cr>', { noremap = true })

-- navigation
vim.keymap.set('n', '<C-\\>', '<Plug>(dirvish_vsplit_up)', {})
vim.keymap.set('v', '<C-p>', 'y<esc>:Rg <C-R>+<cr>', { noremap = true })
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<cr>', { noremap = true })
vim.keymap.set('n', '<leader>zz', ':tabclose<cr>', { noremap = true })
vim.keymap.set('n', '<leader>1', ':Dispatch ', { noremap = true })
vim.keymap.set('n', '<leader>2', ':ToggleQuickFix<cr>', { noremap = true })
vim.keymap.set('n', '<leader>3', ':TroubleToggle<cr>', { noremap = true })
vim.keymap.set('n', '<<', ':colder<cr>', { noremap = true })
vim.keymap.set('n', '>>', ':cnewer<cr>', { noremap = true })
-- folding - Using ufo provider need remap `zR` and `zM`
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', '<Tab>', 'za', { noremap = true })
-- reverse join
vim.keymap.set("n", 'vs', ":lua require('trevj').format_at_cursor()<cr>", { noremap = true })

-- telescope
vim.keymap.set('n', '<space><space>', '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true })
vim.keymap.set('n', '<C-e>', '<cmd>lua require("telescope").extensions.recent_files.pick()<cr>', { noremap = true })
vim.keymap.set('n', '<C-f>', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>',
  { noremap = true })
vim.keymap.set('n', '<leader>e', '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true })
vim.keymap.set('n', '<C-p>', '<cmd>lua require("telescope.builtin").grep_string()<cr>', { noremap = true })

-- debug
vim.keymap.set("n", "<leader>bb", ":lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set("n", "<leader>bl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
vim.keymap.set("n", "<leader>ds", ":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.clear_breakpoints()<cr>")
