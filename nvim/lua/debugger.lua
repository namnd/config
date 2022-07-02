require('dap-go').setup()
require('dapui').setup({
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
require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")
local utils = require("namnd.utils")
dap.listeners.after.event_initialized["dapui_config"] = function()
  utils.push('debug_mode', {
    ["c"] = ":lua require'dap'.continue()<cr>",
    ["n"] = ":lua require'dap'.step_over()<cr>",
    ["i"] = ":lua require'dap'.step_into()<cr>",
    ["o"] = ":lua require'dap'.step_out()<cr>",
  })
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  utils.pop('debug_mode')
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  utils.pop('debug_mode')
  dapui.close()
end
vim.highlight.create('DapBreakpoint', { ctermfg=3 }, false)
vim.highlight.create('DapStoppedText', { ctermfg=2 }, false)
vim.highlight.create('DapStoppedLine', { ctermbg=2, ctermfg=0 }, false)
vim.highlight.create('DapBreakpointRejected', { ctermfg=1 }, false)
vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DapBreakpoint', linehl='', numhl='' })
vim.fn.sign_define('DapStopped', { text='▶', texthl='DapStoppedText', linehl='DapStoppedLine', numhl= 'DapStoppedLine' })
vim.fn.sign_define('DapBreakpointRejected', { text='x', texthl='DapBreakpointRejected', linehl='', numhl='' })
