return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
  use 'tweekmonster/startuptime.vim'
  use 'wuelnerdotexe/vim-enfocado'
  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'
  use 'tpope/vim-endwise'
  use 'jiangmiao/auto-pairs'
  use 'wellle/targets.vim'
  use 'mbbill/undotree'
  use 'junegunn/gv.vim'
  use {
    'shadmansaleh/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'pbogut/fzf-mru.vim'
  use 'stsewd/fzf-checkout.vim'
  use 'neovim/nvim-lspconfig'
  use 'folke/lsp-colors.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
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
  use 'jparise/vim-graphql'
  use 'vim-test/vim-test'
end)
