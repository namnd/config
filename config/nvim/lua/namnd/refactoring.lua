local move = require 'nvim-treesitter.textobjects.move'

local M = {}
function M.extract_variable()
  vim.cmd [[:normal gv"ay]]
  move.goto_previous_start("@function.outer")
  vim.cmd [[:normal o]]
  vim.cmd [[:normal "ap^]]
  vim.cmd [[:normal V>Vw]]
  vim.cmd [[startinsert]]
end

return M
