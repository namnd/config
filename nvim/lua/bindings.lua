-- remap
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("v", "v", "$h", { noremap = true })
vim.api.nvim_set_keymap("n", "E", "ea", { noremap = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })
vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true })
vim.api.nvim_set_keymap("i", ",", ",<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "!", "!<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ".", ".<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "?", "?<C-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", "{<cr>", "{<cr>}<esc>Vk=o", { noremap = true })
vim.api.nvim_set_keymap("i", "(<cr>", "(<cr>)<esc>O", { noremap = true })
vim.api.nvim_set_keymap("i", "[<cr>", "[<cr>]<esc>O", { noremap = true })
vim.api.nvim_set_keymap("i", "({<cr>", "({<cr>})<esc>O", { noremap = true })
vim.api.nvim_set_keymap("i", "({<space>", "({<space><space>})<left><left><left>", { noremap = true })
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

-- dirvish
vim.api.nvim_set_keymap('n', '<C-\\>', '<Plug>(dirvish_vsplit_up)', {})
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(dirvish_split_up)', {})

-- telescope
vim.api.nvim_set_keymap('n', '<space><space>', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pp', '<cmd>Telescope registers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', ':lua require("telescope.builtin").oldfiles({cwd_only = true})<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Rg> ")})<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<cr><cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>11', '<cmd>lua require("telescope").extensions.project.project{}<cr>', {noremap = true})

-- compe
-- Map tab to the above tab complete functions
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<CR>', "compe#confirm({'keys': '<CR>', 'select': v:true })", { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

--vim-test
vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tv', ':TestVisit<cr>', {noremap = true})
