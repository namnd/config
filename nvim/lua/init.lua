require('settings')
require('plugins')

require('setup')
require('bindings')

vim.cmd [[
set termguicolors
colorscheme enfocado
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup
set hidden
set foldexpr=nvim_treesitter#foldexpr()
set wildmode=longest:full,full

let g:dirvish_mode = ':sort ,^.*[\/],'
let g:test#javascript#runner = 'jest'
let g:test#go#runner = 'gotest'
let test#strategy = 'neovim'
let g:preview_markdown_parser = 'glow'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = {'down': '~40%'}
let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1
let g:fzf_checkout_git_options = '--sort=-committerdate'

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
autocmd FileType git,gitcommit setlocal foldmethod=syntax foldenable
]]
