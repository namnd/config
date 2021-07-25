-- remap
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("v", "v", "$h", { noremap = true })
vim.api.nvim_set_keymap("n", "E", "ea", { noremap = true })

-- window/tab navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-x>', ':tabc<cr>', {noremap = true})

-- fugitive
vim.api.nvim_set_keymap('n', '<leader>gs', ':tab G<cr>', {noremap = true})

-- dirvish
vim.api.nvim_set_keymap('n', '<C-\\>', '<Plug>(dirvish_vsplit_up)', {})
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(dirvish_split_up)', {})

-- telescope
vim.api.nvim_set_keymap('n', '<space><space>', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gf', '<cmd>Telescope git_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hh', '<cmd>Telescope search_history<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pp', '<cmd>Telescope registers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Rg> ")})<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<cr><cr>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>11', '<cmd>lua require("telescope").extensions.project.project{}<cr>', {noremap = true})

-- compe
-- Map tab to the above tab complete functions
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<CR>', "compe#confirm({'keys': '<CR>', 'select': v:true })", { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
