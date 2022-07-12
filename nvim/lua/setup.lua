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
  textobjects = {
    select = {
      enable =  true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ip"] = "@parameter.inner",
        ["ap"] = "@parameter.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["vn"] = "@parameter.inner",
      },
      swap_previous = {
        ["vN"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
      },
    },
  },
})

require('Comment').setup()

vim.g.symbols_outline = {
  highlight_hovered_item = false,
  position = 'left',
  relative_width = false,
  width = 60,
  auto_preview = false,
  show_symbol_details = false,
  preview_bg_highlight = 'SignColumn',
  symbol_blacklist = {
    'Field'
  },
  symbols = {
    File = {icon = "F", hl = "TSURI"},
    Module = {icon = "M", hl = "TSNamespace"},
    Package = {icon = "P", hl = "TSNamespace"},
    Method = {icon = "m", hl = "TSMethod"},
    Property = {icon = "p", hl = "TSMethod"},
    Interface = {icon = "i", hl = "TSType"},
    Function = {icon = "f", hl = "TSFunction"},
    Variable = {icon = "v", hl = "TSConstant"},
    Constant = {icon = "c", hl = "TSConstant"},
    Struct = {icon = "s", hl = "TSType"},
  }
}

require('nvim-autopairs').setup()
