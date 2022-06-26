local ts_utils = require'nvim-treesitter.ts_utils'

function RunSingleTest()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return "" end
  local expr = current_node

  local index = 1
  while expr do
    if expr:type() == 'function_declaration' then
      break
    elseif expr:type() == 'method_declaration' then
      index = 2
      break
    end
    expr = expr:parent()
  end

  if not expr then return "" end
  local f_name = (ts_utils.get_node_text(expr:child(index)))[1]
  vim.api.nvim_command(':Dispatch go test -v % -testify.m ' .. f_name)
end

vim.keymap.set("n", "<leader>tt", RunSingleTest)

local group = vim.api.nvim_create_augroup("GoGroup", { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = function ()
    vim.lsp.buf.formatting_sync({}, 1000)
  end
})
