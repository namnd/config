-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<cr>', {noremap = true})

-- git
vim.api.nvim_set_keymap('n', '<leader>gs', ':tab G<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':tabc<cr>', {noremap = true})

-- dirvish
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(dirvish_vsplit_up)', {})
vim.api.nvim_set_keymap('n', '<C-m>', '<Plug>(dirvish_split_up)', {})

-- telescope
vim.api.nvim_set_keymap('n', '<space><space>', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>Telescope oldfiles<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<cr><cr>', {noremap = true})

-- compe
-- Map tab to the above tab complete functions
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
-- Automatically select the first match
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
