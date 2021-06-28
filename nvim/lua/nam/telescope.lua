local M = {}
M.search_dotfiles = function()
  require('telescope.builtin').find_files({
    prompt = "dotfiles >",
    cwd = "~/dotfiles",
  })
end

return M
