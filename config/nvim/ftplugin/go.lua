local ts_utils = require 'nvim-treesitter.ts_utils'

local make_key = function(entry)
  assert(entry.Package, "Must have Package:" .. vim.inspect(entry))
  assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
  return string.format("%s/%s", entry.Package, entry.Test)
end

local add_golang_test = function(state, entry, line)
  state.tests[make_key(entry)] = {
    name = entry.Test,
    line = line,
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

local test_suite_query_string = [[
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
 (#match? @name "^Test[a-zA-Z_]+Suite$")
)
]]

local find_test_suite = function(bufnr)
  local query = vim.treesitter.parse_query("go", test_suite_query_string)
  local parser = vim.treesitter.get_parser(bufnr, "go", {})
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if id == 1 then
      return vim.treesitter.query.get_node_text(node, bufnr)
    end
  end
end

-- get function/method details {name,line,type}
local get_function_at_cursor = function()
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
  local line = node:range()
  return {
    ["name"] = vim.treesitter.query.get_node_text(node, 0),
    ["line"] = line,
    ["type"] = type,
  }
end

local ns = vim.api.nvim_create_namespace "go-tests"

local state = {
  tests = {},
}

function RunSingleTest()
  local bufnr = vim.api.nvim_get_current_buf()
  local function_details = get_function_at_cursor()
  if next(function_details) == nil then
    return
  end

  local command = {}

  if is_integration_test(bufnr) then
    command = { "go", "test", get_go_module_name() .. "/" .. vim.fn.expand('%:h'), "-v", "-testify.m",
      "^" .. function_details.name .. "$", "-json" }
  elseif function_details.type == "m" then
    command = { "go", "test", vim.fn.expand('%'), "-v", "-testify.m", "^" .. function_details.name .. "$", "-json" }
  else
    command = { "go", "test", "./...", "-v", "-run", "^" .. function_details.name .. "$", "-json" }
  end

  -- debug test command
  -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, vim.split(table.concat(command, " "), "\n"))
  vim.api.nvim_buf_set_extmark(bufnr, ns, function_details.line, 0, {
    id = function_details.line,
    sign_text = " ●",
    sign_hl_group = "TestRunning",
  })

  local test_suite = find_test_suite(bufnr)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>o', '', {
    callback = function()
      vim.cmd.new()
      local test_result_bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(test_result_bufnr, 'filetype', 'testresult')
      vim.api.nvim_buf_set_lines(test_result_bufnr, 0, -1, false, { table.concat(command, " "), "" })
      vim.api.nvim_buf_add_highlight(test_result_bufnr, ns, 'TestRunning', 0, 0, -1)
      -- vim.api.nvim_buf_set_lines(test_result_bufnr, 0, -1, false, vim.split(vim.inspect(state), "\n"))
      for _, test in pairs(state.tests) do
        if test_suite == nil or vim.startswith(test.name, test_suite) then
          vim.api.nvim_buf_set_lines(test_result_bufnr, -1, -1, false, test.output)
        end
      end
    end
  })

  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      for _, line in ipairs(data) do
        local decoded = vim.json.decode(line)
        -- debug test output
        -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, vim.split(vim.inspect(decoded), "\n"))
        if decoded.Test then
          if decoded.Action == "run" then
            add_golang_test(state, decoded, function_details.line)
          elseif decoded.Action == "output" then
            add_golang_output(state, decoded)
          elseif decoded.Action == "pass" or decoded.Action == "fail" then
            mark_success(state, decoded)

            local test = state.tests[make_key(decoded)]
            if test.success then
              vim.api.nvim_buf_set_extmark(bufnr, ns, function_details.line, 0, {
                id = function_details.line,
                sign_text = " ",
                sign_hl_group = "TestPassed",
              })
            else
              vim.api.nvim_buf_set_extmark(bufnr, ns, function_details.line, 0, {
                id = function_details.line,
                sign_text = " ",
                sign_hl_group = "TestFailed",
                virt_text = { { " Test failed", "TestFailed" } },
              })
            end
          elseif decoded.Action == "pause" or decoded.Action == "cont" then
            -- do nothing
          else
            error("Failed to handle" .. vim.inspect(data))
          end
        end
      end
    end,

    on_stderr = function(_, data)
      if not data then
        return
      end
      -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
    end,

    on_exit = function()
      -- debug state data
      -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, vim.split(vim.inspect(state), "\n"))
      for _, test in pairs(state.tests) do
        if test.line then
          if not test.success then
            vim.api.nvim_buf_set_extmark(bufnr, ns, function_details.line, 0, {
              id = function_details.line,
              sign_text = " ",
              sign_hl_group = "TestFailed",
              virt_text = { { " Test failed", "TestFailed" } },
            })
          end
        end
      end
    end
  })

end

vim.keymap.set("n", "<leader>tt", RunSingleTest, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>ts", ":Dispatch go test -v %<cr>")
