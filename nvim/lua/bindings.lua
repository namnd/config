-- git
vim.api.nvim_set_keymap('n', '<leader>gs', ':tab G<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':tabc<cr>', {noremap = true})

-- dirvish
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(dirvish_vsplit_up)', {})
vim.api.nvim_set_keymap('n', '<C-m>', '<Plug>(dirvish_split_up)', {})

-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<cr>', {noremap = true})

-- telescope
vim.api.nvim_set_keymap('n', '<space><space>', '<cmd>Telescope find_files<cr>', {noremap = true})


-- compe
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {noremap = true, expr = true})
