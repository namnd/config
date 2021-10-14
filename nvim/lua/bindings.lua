-- remap
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("v", "v", "$h", { noremap = true })
vim.api.nvim_set_keymap("n", "E", "ea", { noremap = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })
-- vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true })
vim.api.nvim_set_keymap("i", ",", ",<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "!", "!<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ".", ".<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "?", "?<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rp", "yiw<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nn', ':noh<cr>', {noremap = true})

-- window/tab navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<cr>', {noremap = true})

-- fugitive
vim.api.nvim_set_keymap('n', '<leader>gg', ':tab G<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>zz', ':tabclose<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gb', ':G blame<cr>', {noremap = true})

-- dirvish
vim.api.nvim_set_keymap('n', '<C-\\>', '<Plug>(dirvish_vsplit_up)', {})
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(dirvish_split_up)', {})
vim.api.nvim_set_keymap('n', '<leader>uu', ':UndotreeToggle<cr>', { noremap = true })

-- fzf
vim.api.nvim_set_keymap('n', '<space><space>', ':GFiles<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', ':FZFMru<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':Rg <C-R>=expand("<cword>")<cr><cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bb', ':Buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ga', ':GBranches<cr>', {noremap = true})

-- vim-test
vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tv', ':TestVisit<cr>', {noremap = true})

-- vim-snip
vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true, noremap = false })
vim.api.nvim_set_keymap('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true, noremap = false })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true, noremap = false })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true, noremap = false })
