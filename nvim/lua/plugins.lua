return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tweekmonster/startuptime.vim'
  use 'jacoborus/tender.vim'
  use 'nvim-lualine/lualine.nvim'
  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'
  use 'tpope/vim-endwise'
  use 'jiangmiao/auto-pairs'
  use 'junegunn/gv.vim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'pbogut/fzf-mru.vim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'mhartington/formatter.nvim'
  --  use 'wellle/targets.vim'
  --  use 'jparise/vim-graphql'
  --  use 'Vimjas/vim-python-pep8-indent'
  --  use 'pedrohdz/vim-yaml-folds'
end)
