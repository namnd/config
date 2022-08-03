P = function (x)
  print(vim.inspect(x))
end

vim.api.nvim_create_user_command('Cheat', 'lua require("namnd.cheatsh").prompt_query()<cr>', {})
