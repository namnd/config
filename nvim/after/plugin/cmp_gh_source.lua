local has_cmp, cmp = pcall(require, "cmp")

if not has_cmp then
  return
end

local source = {}

local get_users = function()
  local cmd = 'git log --format="%(trailers:key=Co-authored-by)"'
  local str = vim.fn.system(cmd)
  local users = {}
  local hash = {}
  for s in str:gmatch("[^\r\n]+") do
    local user = string.sub(s, 17)
    if (not hash[user]) then
      table.insert(users, {
        label = user,
      })
      hash[user] = true
    end
  end
  return users
end

source.new = function()
  local self = setmetatable({ cache = {} }, { __index = source })

  return self
end

source.complete = function(_, _, callback)
  callback { items = get_users(), isIncomplete = false }
end

source.is_available = function()
  return vim.bo.filetype == "gitcommit"
end

cmp.register_source("gh_authors", source.new())
