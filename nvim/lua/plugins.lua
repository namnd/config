vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'tweekmonster/startuptime.vim'
	use 'jacoborus/tender.vim'
	use 'justinmk/vim-dirvish'
	use 'roginfarrer/vim-dirvish-dovish'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'tpope/vim-fugitive'
	use 'neovim/nvim-lspconfig'
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'
	use 'hrsh7th/nvim-compe'
	use 'L3MON4D3/LuaSnip'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
end)
