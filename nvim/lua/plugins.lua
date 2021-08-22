return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
  use 'tweekmonster/startuptime.vim'
  use 'jacoborus/tender.vim'
  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use {
    'shadmansaleh/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  -- use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-project.nvim'
  use 'neovim/nvim-lspconfig'
  use 'folke/lsp-colors.nvim'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'jparise/vim-graphql'
end)
