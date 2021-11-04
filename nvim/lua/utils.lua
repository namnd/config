local api = vim.api
local M = {}

function M.moveWindow(key)
  local current_window = api.nvim_get_current_win()
  api.nvim_command('wincmd ' .. key)
  if current_window == api.nvim_get_current_win() then
    if key == 'h' or key == 'l' then
      api.nvim_command('wincmd v')
    else
      api.nvim_command('wincmd s')
    end
    api.nvim_command('wincmd ' .. key)
  end
end

function M.zoomWindow()
  local number_windows = api.winnr('$')
  print(number_windows)
end

return M
