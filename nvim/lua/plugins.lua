return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- enhancement
  use 'tweekmonster/startuptime.vim'
  use 'lewis6991/impatient.nvim'

  -- navigation
  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'pbogut/fzf-mru.vim'
  use 'tpope/vim-unimpaired'

  -- git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'junegunn/gv.vim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'

  -- lsp
  use 'neovim/nvim-lspconfig'

  -- autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- use 'windwp/nvim-ts-autotag'
  -- use 'JoosepAlviste/nvim-ts-context-commentstring'
  -- use 'mhartington/formatter.nvim'
  -- use 'github/copilot.vim'
  -- use 'petobens/poet-v'

  -- python
  use 'Vimjas/vim-python-pep8-indent'

  -- others
  use 'mtth/scratch.vim'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-endwise'
  use 'tpope/vim-dispatch'
  use 'wellle/targets.vim'
  use 'jiangmiao/auto-pairs'
  use 'junegunn/vim-easy-align'

end)
