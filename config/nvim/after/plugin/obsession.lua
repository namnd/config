local has_obsession = pcall(vim.fn["ObsessionStatus"])

if not has_obsession then
  return
end
vim.api.nvim_create_augroup("ObsessionCheck", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = "ObsessionCheck",
  callback = function()
    local status = vim.api.nvim_exec([[ echo ObsessionStatus() ]], true)
    if status ~= "[$]" then
      vim.api.nvim_command('silent! Obsession')
    end
  end
})

vim.keymap.set("n", "<C-s>", ':Obsession<cr>', { noremap = true })
