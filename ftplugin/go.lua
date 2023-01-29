local ts_utils = require 'nvim-treesitter.ts_utils'

local ns = vim.api.nvim_create_namespace "go-tests"

local test_result_bufnr = nil
local init_test_result_bufnr = function()
  if not test_result_bufnr then
    test_result_bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(test_result_bufnr, 'filetype', 'testresult')
  end
  vim.api.nvim_buf_set_option(test_result_bufnr, 'modifiable', true)
end

local make_key = function(entry)
  assert(entry.Package, "Must have Package:" .. vim.inspect(entry))
  assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
  if entry.Package == "command-line-arguments" then
    return entry.Test
  end
  return string.format("%s/%s", entry.Package, entry.Test)
end

local add_golang_test = function(state, entry, line, line_end)
  state.tests[make_key(entry)] = {
    name = entry.Test,
    line = line,
    line_end = line_end,
    output = {},
  }
end

local add_golang_output = function(state, entry)
  assert(state.tests, vim.inspect(state))
  table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
end

local mark_success = function(state, entry)
  state.tests[make_key(entry)].success = entry.Action == "pass"
end

local file_exists = function(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local get_go_module_name = function()
  local gomod = "./go.mod"
  if not file_exists(gomod) then return {} end
  for line in io.lines(gomod) do
    return line:match("module (.+)")
  end
  return {}
end

local is_integration_test = function(bufnr)
  local line = vim.trim(vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1])
  for _, item in ipairs({ "// +build ", "//go:build " }) do
    if vim.startswith(line, item) then
      return true
    end
  end
  return false
end

local is_using_testify_suite = function()
  return vim.fn.search('testify/suite', 'n') > 0
end

local test_query_string = [[
(
  (function_declaration
    name: (identifier) @name
    parameters:
      (parameter_list
       (parameter_declaration
        name: (identifier)
        type: (pointer_type
            (qualified_type
             package: (package_identifier) @_package_name
             name: (type_identifier) @_type_name)))))

   (#eq? @_package_name "testing")
   (#eq? @_type_name "T")
   (#match? @name "%s")
)
]]

local testify_suite_test_query_string = [[
(
  (method_declaration
    name: (field_identifier) @test.name

  (#match? @test.name "%s")) @test.definition
)
]]

local test_query = function(name)
  name = name and "^" .. name .. "$" or "^Test"
  if is_using_testify_suite() then
    return string.format(testify_suite_test_query_string, name)
  end
  return string.format(test_query_string, name)
end

---Find lines of all the tests
---@return table
local find_all_test_lines = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local query = vim.treesitter.parse_query("go", test_query())
  local parser = vim.treesitter.get_parser(bufnr, "go", {})
  local tree = parser:parse()[1]
  local root = tree:root()

  local test_lines = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if id == 1 then
      table.insert(test_lines, ({ node:range() })[1])
    end
  end
  return test_lines
end

---Find line/line_end of the test (by name)
local find_test_line = function(name)
  local names = vim.split(name, "/")
  if #names > 1 then
    name = names[2]
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local query = vim.treesitter.parse_query("go", test_query(name))
  local parser = vim.treesitter.get_parser(bufnr, "go", {})
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if id == 1 then
      return ({ node:range() })[1], ({ node:parent():range() })[3]
    end
  end
end

---Get the single test at cursor
---@return table
local get_test_at_cursor = function()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return {} end
  local expr = current_node

  local index, type = 1, ""
  while expr do
    if expr:type() == 'function_declaration' then
      type = "f"
      break
    elseif expr:type() == 'method_declaration' then
      index = 2
      type = "m"
      break
    end
    expr = expr:parent()
  end

  if not expr then return {} end
  local node = expr:child(index)
  local name = vim.treesitter.query.get_node_text(node, 0)
  if not vim.startswith(name, "Test") then return {} end

  return {
    ["name"] = name,
    ["line"] = node:range(),
    ["type"] = type,
    ["line_end"] = ({ expr:range() })[3],
  }
end

---Construct command for running test(s) depends on various inputs
---If test_name is not provided, it will run test on the whole file
---@param bufnr integer
---@param test_name string?
---@return table
local build_command = function(bufnr, test_name)
  local dir = "./..."
  if is_integration_test(bufnr) then
    dir = get_go_module_name() .. "/" .. vim.fn.expand('%:h')
  elseif is_using_testify_suite() then
    dir = vim.fn.expand('%')
  end

  local command = { "go", "test", "-v", "-json", dir }

  if test_name ~= nil then
    local arg = is_using_testify_suite() and "-testify.m" or "-run"
    vim.list_extend(command, { arg, "^" .. test_name .. "$" })
  end

  -- display command to the test result buffer
  vim.api.nvim_buf_set_lines(test_result_bufnr, 0, -1, false, { table.concat(command, " "), "" })
  vim.api.nvim_buf_add_highlight(test_result_bufnr, ns, 'TestRunning', 0, 0, -1)

  return command
end

---Parse command output (json) to state object for displaying once finished
---@param state table
---@param data string
---@param function_details table?
local parse_output_data = function(state, data, function_details)
  if not data then return end

  for _, line in ipairs(data) do
    if line ~= "" then

      local ok, decoded = pcall(vim.json.decode, line)
      if not ok then
        error("Failed to decode data " .. vim.inspect(line))
      end

      -- vim.api.nvim_buf_set_lines(0, -1, -1, false, vim.split(vim.inspect(decoded), "\n"))
      if decoded.Test then
        local test_line, line_end = nil, nil
        if function_details == nil then
          test_line, line_end = find_test_line(decoded.Test)
        else
          test_line = function_details.line
          line_end = function_details.line_end
        end

        if decoded.Action == "run" then
          add_golang_test(state, decoded, test_line, line_end)
        elseif decoded.Action == "output" then
          add_golang_output(state, decoded)
        elseif decoded.Action == "pass" or decoded.Action == "fail" then
          mark_success(state, decoded)
        elseif decoded.Action == "pause" or decoded.Action == "cont" then
          -- do nothing
        else
          error("Failed to handle" .. vim.inspect(decoded))
        end
      end
    end
  end
end

---Display test results based on the state
---@param bufnr integer
---@param state table
local display_test_result = function(bufnr, state)
  -- vim.api.nvim_buf_set_lines(test_result_bufnr, 0, -1, false, vim.split(vim.inspect(state.tests), "\n"))
  -- first display the suite one (if there is any)
  for _, test in pairs(state.tests) do
    if vim.endswith(test.name, "Suite") then
      vim.api.nvim_buf_set_lines(test_result_bufnr, -1, -1, false, test.output)
    end
  end

  -- next sort the rest by line number, also excluding the suite
  local lines = {}
  local tests_by_line = {}
  for _, test in pairs(state.tests) do
    if test.line and not vim.endswith(test.name, "Suite") then
      table.insert(lines, test.line)
      tests_by_line[test.line] = test
    end
  end

  -- sort by line ascending
  table.sort(lines)
  local has_failed_test = false

  for _, line in ipairs(lines) do
    local test = tests_by_line[line]
    vim.api.nvim_buf_set_lines(test_result_bufnr, -1, -1, false, test.output)

    if test.success then
      vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
        id = line,
        sign_text = " ",
        sign_hl_group = "TestPassed",
      })
    else
      vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
        id = line,
        sign_text = " ",
        sign_hl_group = "TestFailed",
        virt_text = { { " Test failed", "TestFailed" } },
      })
      has_failed_test = true
    end
  end

  if has_failed_test and vim.fn.getbufinfo(test_result_bufnr)[1].hidden == 1 then
    ToggleTestResult()
  end
  vim.api.nvim_buf_set_option(test_result_bufnr, 'modifiable', false)
end

function ToggleTestResult()
  if test_result_bufnr == nil then
    return
  end

  if vim.fn.getbufinfo(test_result_bufnr)[1].hidden == 1 then
    vim.api.nvim_command(':sb' .. test_result_bufnr)
    vim.api.nvim_command('wincmd k')
  else
    vim.api.nvim_command('wincmd j')
    vim.api.nvim_command('hide')
  end
end

function RunSingleTest()
  local state = {
    tests = {},
  }

  -- find the nearest test
  local bufnr = vim.api.nvim_get_current_buf()
  local test = get_test_at_cursor()
  if next(test) == nil then
    print("Oops, not a test")
    return
  end

  -- prepare test result buffer
  init_test_result_bufnr()

  -- construct the test command
  local command = build_command(bufnr, test.name)

  -- start running test
  vim.api.nvim_buf_set_extmark(bufnr, ns, test.line, 0, {
    id = test.line,
    sign_text = " ●",
    sign_hl_group = "TestRunning",
  })

  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data) parse_output_data(state, data, test) end,
    on_exit = function() display_test_result(bufnr, state) end,
  })

end

function RunFileTests()
  local state = {
    tests = {},
  }

  -- find all the tests
  local bufnr = vim.api.nvim_get_current_buf()
  local test_lines = find_all_test_lines()
  if #test_lines == 0 then
    print("Oops, there is no test")
    return
  end

  -- prepare test result buffer
  init_test_result_bufnr()

  -- construct the test command
  local command = build_command(bufnr)

  -- start running test
  for _, test_line in ipairs(test_lines) do
    vim.api.nvim_buf_set_extmark(bufnr, ns, test_line, 0, {
      id = test_line,
      sign_text = " ●",
      sign_hl_group = "TestRunning",
    })
  end

  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data) parse_output_data(state, data) end,
    on_exit = function() display_test_result(bufnr, state) end,
  })

end

vim.keymap.set('n', '<leader>o', ToggleTestResult, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tt", RunSingleTest, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tf", RunFileTests, { silent = true, noremap = true })
