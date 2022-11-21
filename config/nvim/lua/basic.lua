vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'nv'
vim.o.splitright = true
vim.o.splitbelow = true
vim.wo.list = true
vim.o.listchars = 'tab:| ,trail:·,eol:↵'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.wildmode = 'longest:full,full'
vim.o.ch = 0

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.wo.number = true
vim.wo.signcolumn = 'yes:2'

vim.g.mapleader = ' '
vim.o.foldlevel = 15 -- Using ufo provider need a large value
vim.o.foldlevelstart = 15
vim.o.foldenable = true
