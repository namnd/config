require('impatient')

require('gitsigns').setup()

require('nvim-treesitter.configs').setup ({
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = { "python" },
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<cr>',
      scope_incremental = '<cr>',
      node_incremental = '<tab>',
      node_decremental = '<s-tab>',
    },
  },
})

-- require'nvim-treesitter.configs'.setup {
--   context_commentstring = {
--     enable = true,
--     config = {
--       typescript = {
--         __default = '// %s',
--         jsx_element = '{/* %s */}',
--         jsx_fragment = '{/* %s */}',
--         jsx_attribute = '// %s',
--         comment = '// %s'
--       }
--     }
--   }
-- }

-- local prettier = function()
--   return {
--     exe = "prettierd",
--     args = {vim.api.nvim_buf_get_name(0)},
--     stdin = true
--   }
-- end
-- require('formatter').setup({
--   filetype = {
--     javascript = { prettier },
--     typescript = { prettier },
--     javascriptreact = { prettier },
--     typescriptreact = { prettier },
--   }
-- })
