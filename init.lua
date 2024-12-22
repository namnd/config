-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

if vim.loader then
  vim.loader.enable()
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'   -- plugin manager
  use 'tweekmonster/startuptime.vim'
  use 'lewis6991/impatient.nvim' -- improve startup time
  use 'mbbill/undotree'          -- local file history
  use { 'namnd/oil.nvim', config = function()
    require('oil').setup({
      skip_confirm_for_simple_edits = true,
      view_options                  = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == 'Session.vim'
        end,
      },
    })
  end }
  use 'tpope/vim-obsession' -- session manager
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'   -- github
  use 'namnd/gv.vim'        -- git commit browser
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-abolish' -- fooBar into foo_bar or FooBar
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-endwise'
  use { 'junegunn/fzf.vim' }
  use { 'pbogut/fzf-mru.vim' }
  use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end }
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use { 'github/copilot.vim' }

  -- ./after/plugin/gitsigns.lua
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- ./after/plugin/ufo.lua
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

  -- ./after/plugin/treesitter.lua
  use { 'nvim-treesitter/nvim-treesitter',
    run = function() pcall(require('nvim-treesitter.install').update { with_sync = true }) end }
  -- use 'nvim-treesitter/playground'
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
  use { 'AckslD/nvim-trevJ.lua', config = function() require("trevj").setup() end } -- reverse join-line using treesitter

  -- ./after/plugin/lsp.lua
  use { 'neovim/nvim-lspconfig' }
  use { 'nvim-lua/lsp-status.nvim' }

  -- ./after/plugin/cmp.lua
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'onsails/lspkind.nvim' }

  use 'tpope/vim-dadbod'
  use 'kristijanhusak/vim-dadbod-ui'
  use 'kristijanhusak/vim-dadbod-completion'

  use 'alligator/accent.vim'

  -- ./after/plugin/dap.lua
  -- use { 'mfussenegger/nvim-dap' }
  -- use { 'leoluz/nvim-dap-go' }
  -- use { 'rcarriga/nvim-dap-ui' }
  -- use { 'theHamsta/nvim-dap-virtual-text' }

  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print 'Plugins are about to be installed, please restart neovim once it finished'
  return
end

require('impatient')
require("namnd.notes")

vim.cmd [[
let g:accent_colour = 'blue'
let g:accent_darken = 1
let g:accent_no_bg = 1
colorscheme accent
]]

-- Basic settings
vim.g.mapleader = ' '
vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'nv'
vim.o.splitright = true
vim.o.splitbelow = true
vim.wo.list = true
vim.o.listchars = 'tab:| ,trail:·,eol:↵'
vim.o.completeopt = 'menu,menuone,noselect' -- for nvim-cmp
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.wildmode = 'longest:full,full'
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.wo.cursorline = true
vim.wo.number = true
vim.wo.signcolumn = 'yes:2'
vim.wo.conceallevel = 0
vim.o.foldlevel = 99 -- Using ufo provider need a large value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})
-- Keymaps
vim.keymap.set("v", "v", "$h", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("n", "E", "ea", { noremap = true })
vim.keymap.set("n", "<leader>rp", "yiwy<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("v", "<leader>rp", "y<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("n", "<<", ':colder<cr>', { noremap = true })
vim.keymap.set("n", ">>", ':cnewer<cr>', { noremap = true })
vim.keymap.set("n", "<leader>ch", '<cmd>lua require("namnd.cheatsh").prompt_query()<cr>', { noremap = true })
vim.keymap.set("n", '<leader>K', '<cmd>lua require("trevj").format_at_cursor()<cr>', { noremap = true })
vim.keymap.set('n', '<leader>gg', ":tab G<cr>", { noremap = true })
vim.keymap.set('n', '<leader>zz', ":tabclose<cr>", { noremap = true })
vim.keymap.set('n', '<leader>=', "<cmd>lua vim.lsp.buf.format()<cr>", { noremap = true })
vim.keymap.set('n', "F6", "<C-i>", { noremap = true })
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
vim.keymap.set('n', '<leader>ff', ':FZF<cr>', {})
vim.keymap.set('n', '<leader>fb', ':Buffers<cr>', {})
vim.keymap.set('n', '<leader>fr', ':FZFMru<cr>', {})
vim.keymap.set("n", "<leader>2", function()
  if vim.fn.getqflist({ winid = 0 }).winid == 0 then
    vim.api.nvim_command('copen')
  else
    vim.api.nvim_command('cclose')
  end
end, { noremap = true })

vim.cmd [[
set winbar=%m\ %f\ (%n)%=%P\ %r%y
set laststatus=3
set statusline=%!v:lua.require('namnd.statusline').global()

let g:fzf_layout = { 'down': '40%' }
let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1

augroup FiletypeGroup
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
  autocmd VimResized * :wincmd =
  autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
  autocmd BufNewFile,BufRead *.tf,*.tfvars,*.hcl set filetype=terraform
  autocmd BufNewFile,BufRead *.hujson set filetype=json
  autocmd BufNewFile,BufRead *gitconfig set filetype=toml
  autocmd BufNewFile,BufRead *zshrc set filetype=bash
  autocmd BufNewFile,BufRead scratch set filetype=markdown
  autocmd BufNewFile,BufRead *.hujson setlocal filetype=jsonc
  autocmd FileType git setlocal foldmethod=syntax foldenable
  autocmd FileType yml,yaml setlocal foldmethod=indent
  autocmd FileType markdown setlocal foldmethod=expr
  autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
augroup END
]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Automatically source and re-compile packer whenever you save this init.lua
autocmd('BufWritePost', {
  group = augroup('Packer', { clear = true }),
  pattern = vim.fn.expand '$MYVIMRC',
  command = 'source <afile> | PackerCompile',
})

autocmd('VimEnter', {
  group = augroup('ObsessionCheck', { clear = true }),
  callback = function()
    local status = vim.api.nvim_exec([[ echo ObsessionStatus() ]], true)
    if status ~= "[$]" then
      vim.api.nvim_command('silent! Obsession')
    end
  end
})
