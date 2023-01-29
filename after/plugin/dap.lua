local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

local has_dap_go, dap_go = pcall(require, 'dap-go')
if has_dap_go then
  dap_go.setup()
end

local has_dapui, dapui = pcall(require, 'dapui')
if has_dapui then
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.5 },
        },
        size = 40,
        position = "right",
      },
      {
        elements = {
          "repl",
          "watches",
        },
        size = 0.4,
        position = "bottom",
      },
    },
  })
end

local has_dap_virtual_text, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if has_dap_virtual_text then
  dap_virtual_text.setup({})
end

local stackmap = require("namnd.stackmap")
dap.listeners.after.event_initialized["dapui_config"] = function()
  stackmap.push('debug_mode', {
    ["c"] = ":lua require'dap'.continue()<cr>",
    ["n"] = ":lua require'dap'.step_over()<cr>",
    ["i"] = ":lua require'dap'.step_into()<cr>",
    ["o"] = ":lua require'dap'.step_out()<cr>",
  })
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  stackmap.pop('debug_mode')
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  stackmap.pop('debug_mode')
  dapui.close({})
end

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStoppedText', linehl = 'DapStoppedLine',
  numhl = 'DapStoppedLine' })
vim.fn.sign_define('DapBreakpointRejected', { text = 'x', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

vim.keymap.set("n", "<leader>bb", ":lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set("n", "<leader>bl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
vim.keymap.set("n", "<leader>ds", ":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.clear_breakpoints()<cr>")
