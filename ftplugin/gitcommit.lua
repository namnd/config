local has_cmp, cmp = pcall(require, "cmp")

if not has_cmp then
  return
end

cmp.setup({
  completion = {
    autocomplete = false,
  },
})
