require('impatient')

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require('nvim-treesitter.configs').setup ({
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = { "python" },
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<cr>',
      scope_incremental = '<cr>',
      node_incremental = '<tab>',
      node_decremental = '<s-tab>',
    },
  },
})

require('Comment').setup()
require('dap-go').setup()
require('dapui').setup({
  sidebar = {
    elements = {
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.75 },
    }
  },
  tray = {
    elements = {
      { id = "scopes", size = 0.5 },
      { id = "watches", size = 0.5 },
    },
  },
})
require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
vim.highlight.create('DapBreakpoint', { ctermfg=3 }, false)
vim.highlight.create('DapStoppedText', { ctermfg=2 }, false)
vim.highlight.create('DapStoppedLine', { ctermbg=2, ctermfg=0 }, false)
vim.highlight.create('DapBreakpointRejected', { ctermfg=1 }, false)
vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DapBreakpoint', linehl='', numhl='' })
vim.fn.sign_define('DapStopped', { text='▶', texthl='DapStoppedText', linehl='DapStoppedLine', numhl= 'DapStoppedLine' })
vim.fn.sign_define('DapBreakpointRejected', { text='x', texthl='DapBreakpointRejected', linehl='', numhl='' })

require('syntax-tree-surfer').setup()
