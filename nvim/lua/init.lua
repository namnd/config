require('settings')
require('plugins')

vim.cmd('colorscheme tender')

require('setup')
require('bindings')

vim.cmd [[
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup
set hidden
set foldexpr=nvim_treesitter#foldexpr()
set wildmode=longest:full,full

let g:dirvish_mode = ':sort ,^.*[\/],'
let g:test#javascript#runner = 'jest'
let test#strategy = 'neovim'
let g:preview_markdown_parser = 'glow'

imap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
]]
