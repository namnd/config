local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local lga_actions = require("telescope-live-grep-args.actions")
require('telescope').setup({
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
      width = 170,
      preview_width = 0.6,
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<esc>"] = actions.close,
        ["<C-p>"] = action_layout.toggle_preview,
      }
    },
    preview = {
      hide_on_startup = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {
        i = {
          ["<C-k>"] = "move_selection_previous", -- override default mapping
          ["<C-l>q"] = lga_actions.quote_prompt(),
        },
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {"rg", "--files", "--hidden", "-g", "!.git"},
    },
  },
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
