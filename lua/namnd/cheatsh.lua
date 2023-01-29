local M = {}

M.prompt_query = function()
  local ft = vim.bo.filetype
  local query = nil
  vim.ui.input({
    prompt = 'cheat.sh > ' .. ft .. ' '
  }, function(input)
    query = input
  end)
  if query then
    vim.cmd [[ new ]]
    vim.api.nvim_command('read !CHTSH_QUERY_OPTIONS="T" cht.sh ' .. ft .. ' ' .. query)
    vim.api.nvim_buf_set_option(0, 'filetype', ft)
    vim.api.nvim_buf_set_option(0, 'buftype', 'nofile')
  end
end

return M
