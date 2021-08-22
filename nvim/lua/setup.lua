require('gitsigns').setup()

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    icons_enabled = false,
    theme = 'ayu_dark'
  },
  sections = {
    lualine_c = {'filename', 'b:gitsigns_status'}
  }
})

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('project')

local nvim_lsp = require('lspconfig')
local on_attach = function(_, bufnr)
	local opts = { noremap=true, silent=true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>zz', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ww', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits'
  }
}

local servers = {'tsserver', 'terraformls', 'pyright'}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

require'lspconfig'.gopls.setup{
  on_attach=on_attach,
  capabilities = capabilities,
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

require('compe').setup {
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    luasnip = false,
    calc = false,
    nvim_lua = false,
    vsnip = true,
    ultisnips = false,
  },
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
-- - move to prev/next item in completion menu
-- - jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t '<C-n>'
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t '<Plug>(vsnip-expand-or-jump)'
	elseif check_back_space() then
		return t '<Tab>'
	else
		return vim.fn['compe#complete']()
	end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<S-Tab>'
  end
end

require('nvim-treesitter.configs').setup ({
	highlight = { enable = true },
  indent = { enable = true },
  -- autotag = { enable = true },
})
