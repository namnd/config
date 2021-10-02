nnoremap <buffer> <leader>ee :w<CR>:! go run "%"<CR>
autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
