local M = {}

local mode = "n"

M.find_mapping = function(lhs)
  local maps = vim.api.nvim_get_keymap(mode)
  for _, value in ipairs(maps) do
    if value.lhs == lhs then
      return value
    end
  end
end

M._stack = {}

M.push = function(name, mappings)
  local before = {}
  -- back up the before mappings
  for lhs in pairs(mappings) do
    local existing = M.find_mapping(lhs)
    if existing then
      before[lhs] = existing
    end
  end

  -- set new mappings
  for lhs, rhs in pairs(mappings) do
    vim.keymap.set(mode, lhs, rhs)
  end

  M._stack[name] = M._stack[name] or {}
  M._stack[name] = {
    before = before,
    mappings = mappings,
  }
end

M.pop = function(name)
  local state = M._stack[name]
  M._stack[name] = nil

  for lhs in pairs(state.mappings) do
    if state.before[lhs] then
      local mapping_before = state.before[lhs]
      vim.keymap.set(mode, lhs, mapping_before.rhs)
    else
      vim.keymap.del(mode, lhs)
    end
  end
end

return M
