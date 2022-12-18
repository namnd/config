require("namnd.packer")
require("namnd.keymaps")
require("namnd.settings")
require("namnd.statusline")
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

pcall(require, 'impatient')

vim.cmd [[
set winbar=%m\ %f\ (%n)%=%P\ %r%y
set laststatus=3
set statusline=%!v:lua.require('namnd.statusline').global()

augroup FiletypeGroup
  autocmd!
  autocmd FileType git,gitcommit setlocal foldmethod=syntax foldenable
  autocmd FileType yml,yaml setlocal foldmethod=indent
  autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
  autocmd BufNewFile,BufRead *.tfvars set filetype=terraform
  autocmd BufNewFile,BufRead *.hujson set filetype=json
augroup END
]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      timeout = 70,
    })
  end,
})

local lspformat_group = augroup('LspFormatGroup', { clear = true })
autocmd('BufWritePre', {
  group = lspformat_group,
  pattern = '*',
  callback = function()
    vim.lsp.buf.format()
  end,
})

local misc_group = augroup('MiscGroup', { clear = true })
autocmd('VimResized', {
  group = misc_group,
  pattern = '*',
  command = 'wincmd =',
})
