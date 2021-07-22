require('lualine').setup()
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.compe').setup({
	map_cr = true,
	map_complete = true
})

local nvim_lsp = require('lspconfig')
local on_attach = function(_, bufnr)
	local opts = { noremap=true, silent=true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {'tsserver'}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = true,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col '.' - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match '%' then
		return true
	else
		return false
	end
end

-- Use (s-)tab to:
-- - move to prev/next item in completion menu
-- - jump to prev/next snippet's placeholder
local luasnip = require 'luasnip'

_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t '<C-n>'
	elseif luasnip.expand_or_jumpable() then
		return t '<Plug>luasnip-expand-or-jump'
	elseif check_back_space() then
		return t '<Tab>'
	else
		return vim.fn['compe#complete']()
	end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

require('nvim-treesitter.configs').setup ({
	highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
})
