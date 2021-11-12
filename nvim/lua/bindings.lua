-- remap
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("v", "v", "$h", { noremap = true })
vim.api.nvim_set_keymap('n', 'K', "f s<enter><esc>", {noremap = true})
vim.api.nvim_set_keymap("n", "E", "ea", { noremap = true })
vim.api.nvim_set_keymap("i", ",", ",<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "!", "!<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ".", ".<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "?", "?<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rp", "yiw<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nn', ':noh<cr>', {noremap = true})

-- window/tab navigation
vim.api.nvim_set_keymap('n', '<C-h>', "<cmd>lua require'utils'.moveWindow('h')<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', "<cmd>lua require'utils'.moveWindow('j')<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', "<cmd>lua require'utils'.moveWindow('l')<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', "<cmd>lua require'utils'.moveWindow('k')<cr>", {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<cr>', {noremap = true})

-- fugitive
vim.api.nvim_set_keymap('n', '<leader>gg', ':tab G<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>zz', ':tabclose<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gb', ':G blame<cr>', {noremap = true})

-- dirvish
vim.api.nvim_set_keymap('n', '<C-\\>', '<Plug>(dirvish_vsplit_up)', {})
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(dirvish_split_up)', {})

-- fzf
vim.api.nvim_set_keymap('n', '<space><space>', ':GFiles<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', ':FZFMru<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':Rg <C-R>=expand("<cword>")<cr><cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bb', ':Buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-Space>', ":call fzf#run(fzf#wrap({'source': 'find $HOME/Code -maxdepth 2 -type d'}))<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<cr>', {noremap = true})

-- vim-snip
vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true, noremap = false })
vim.api.nvim_set_keymap('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true, noremap = false })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true, noremap = false })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true, noremap = false })

-- dispatch
vim.api.nvim_set_keymap('n', '<leader>ee', ':Dispatch ', {noremap = true})
