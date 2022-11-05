local git_add_color = vim.api.nvim_get_hl_by_name('GitSignsAdd', true)
local git_change_color = vim.api.nvim_get_hl_by_name('GitSignsChange', true)
local git_delete_color = vim.api.nvim_get_hl_by_name('GitSignsDelete', true)
local statusline_color = vim.api.nvim_get_hl_by_name('StatusLine', true)

git_add_color.background = statusline_color.background
git_change_color.background = statusline_color.background
git_delete_color.background = statusline_color.background
vim.api.nvim_set_hl(0, 'StatusLineGitAdd', git_add_color)
vim.api.nvim_set_hl(0, 'StatusLineGitChange', git_change_color)
vim.api.nvim_set_hl(0, 'StatusLineGitDelete', git_delete_color)

local statusline_mode_color = {
  ["bg"] = "black",
  ["bold"] = true,
}
vim.api.nvim_set_hl(0, 'StatusLineNormal', statusline_mode_color)
statusline_mode_color.fg = "green"
vim.api.nvim_set_hl(0, 'StatusLineInsert', statusline_mode_color)
statusline_mode_color.fg = "yellow"
vim.api.nvim_set_hl(0, 'StatusLineVisual', statusline_mode_color)

local modes_map = {
  ["n"] = "NORMAL",
  ["i"] = "INSERT",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["c"] = "COMMAND",
}

local function get_mode_color()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineNormal#"
  if current_mode == "i" then
    mode_color = "%#StatusLineInsert#"
  elseif current_mode == "V" or current_mode == "" then
    mode_color = "%#StatusLineVisual#"
  end
  return mode_color
end

local function get_mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return table.concat {
    get_mode_color(),
    " ", modes_map[current_mode], " ",
    "%#StatusLine#",
  }
end

local function git_signs()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return vim.api.nvim_eval('FugitiveStatusline()')
  end
  local added = git_info.added and ("%#StatusLineGitAdd#+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#StatusLineGitChange#~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#StatusLineGitDelete#-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat {
    "(",
    git_info.head,
    ") ",
    added,
    changed,
    removed,
  }
end

local M = {}

M.global = function()
  return table.concat {
    get_mode(), " ",
    vim.fn.fnamemodify(vim.api.nvim_eval('getcwd()'), ":~"), " ",
    git_signs(),
    "%=",
    "%#StatusLine#%w%l,%-10.c%L", " ",
  }
end

return M
