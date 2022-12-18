-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-vinegar' -- file explorer
  use 'tpope/vim-obsession' -- session manager

  -- git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'junegunn/gv.vim'
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'mbbill/undotree' -- local file history

  -- folds
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'smartpde/telescope-recent-files'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use 'nvim-treesitter/playground'
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- lsp & autocompletion
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- dap
  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  -- enhancement
  use 'tweekmonster/startuptime.vim'
  use 'lewis6991/impatient.nvim'

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-endwise'
  use 'tpope/vim-abolish'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-dispatch'
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup() end
  }
  use 'AckslD/nvim-trevJ.lua' -- reverse join-line using treesitter
  use { 'Julian/vim-textobj-variable-segment', requires = 'kana/vim-textobj-user' }

  if is_bootstrap then
    require('packer').sync()
  end
end)
