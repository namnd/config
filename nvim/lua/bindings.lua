-- remap
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("v", "v", "$h", { noremap = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("n", "E", "ea", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rp", "yiw<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.api.nvim_set_keymap("n", 'ga', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap("x", 'ga', '<Plug>(EasyAlign)', {})

-- git
vim.api.nvim_set_keymap('n', '<leader>gg', ':tab G<cr>', {noremap = true})

-- navigation
vim.api.nvim_set_keymap('n', '<C-\\>', '<Plug>(dirvish_vsplit_up)', {})
vim.api.nvim_set_keymap('n', '<space><space>', ':GFiles<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', ':FZFMru<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':Rg <C-R>=expand("<cword>")<cr><cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-Space>', ":call fzf#run(fzf#wrap({'source': 'find $HOME/workspaces/indebted -maxdepth 1 -type d', 'options': '--no-preview'}))<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>zz', ':tabclose<cr>', {noremap = true})

-- debug
vim.keymap.set("n", "<F1>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F4>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>bb", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.clear_breakpoints()<CR>")
vim.keymap.set("n", "<leader>dl", ":lua require'dap'.list_breakpoints()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")
