local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
local has_lsp_status, lsp_status = pcall(require, 'lsp-status')
local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')

if has_lsp_status then
  lsp_status.config({
    status_symbol = '',
    indicator_errors = 'E',
    indicator_warnings = 'W',
    indicator_info = 'I',
    indicator_hint = '?',
    indicator_ok = 'OK',
  })
  lsp_status.register_progress()
end

if not has_lspconfig then
  return
end

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', '<leader>ww', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set('n', '<leader>ll', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
if has_cmp then
  capabilities = cmp.default_capabilities()
end
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local servers = {
  'ts_ls',
  'terraformls',
  'clangd',
  'nixd',
  'zls',
  'pyright',
  'rust_analyzer',
  'dartls',
  'html',
  'jsonls',
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.html.setup({
  cmd = {"html-languageserver", "--stdio"}
})

lspconfig.jsonls.setup({
  filetypes = {"json", "jsonc"}
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
local library = vim.api.nvim_get_runtime_file("", true)
table.insert(library, '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/')
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim', 'hs' }
      },
      workspace = {
        library = library,
      },
      telemetry = {
        enable = false,
      },
    }
  },
  on_attach = on_attach,
  capabilities = capabilities,
})
