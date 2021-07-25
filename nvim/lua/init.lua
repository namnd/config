require('settings')
require('plugins')

vim.cmd('colorscheme tender')

require('setup')
require('bindings')

vim.cmd [[
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup
set foldexpr=nvim_treesitter#foldexpr()

nmap <leader>p "0p
nmap <leader>P "0P

let g:dirvish_mode = ':sort ,^.*[\/],'

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
]]
