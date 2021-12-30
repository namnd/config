vim.o.clipboard = 'unnamed'
vim.o.mouse = 'nv'
vim.o.splitright = true
vim.o.splitbelow = true
vim.wo.list = true
vim.o.listchars = 'tab:|_,trail:·,eol:↵'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.wildmode= 'longest:full,full'

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.wo.number = true
vim.wo.signcolumn = 'yes:2'
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldenable = false

vim.g.mapleader = ','
