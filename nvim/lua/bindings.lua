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
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(dirvish_split_up)', {})
vim.api.nvim_set_keymap('n', '<space><space>', ':GFiles<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', ':FZFMru<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':Rg <C-R>=expand("<cword>")<cr><cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-Space>', ":call fzf#run(fzf#wrap({'source': 'find $HOME/workspaces/indebted -maxdepth 1 -type d', 'options': '--no-preview'}))<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>zz', ':tabclose<cr>', {noremap = true})

-- dispatch
vim.api.nvim_set_keymap('n', '<leader>1', ':Dispatch ', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>2', ':copen<cr> ', {noremap = true})
