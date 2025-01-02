local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'nv'
vim.wo.list = true
vim.o.listchars = 'tab:| ,trail:·,eol:↵'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.wo.cursorline = true
vim.wo.number = true
vim.wo.signcolumn = 'yes:1'
vim.wo.conceallevel = 0
vim.o.foldlevel = 10
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.o.swapfile = false
vim.o.backup = false
vim.loader.enable()

vim.keymap.set('n', '<leader>zz', ":tabclose<cr>", { noremap = true })
vim.keymap.set("v", "v", "$h", { noremap = true })
vim.keymap.set("n", "E", "ea", { noremap = true })
vim.keymap.set("n", "<leader>rp", "yiwy<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("v", "<leader>rp", "y<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })

vim.filetype.add({
  extension = {
    hujson = "jsonc",
  },
  filename = {
    ["zshrc"] = "bash",
    ["scratch"] = "markdown",
  },
})

-- Notes scratch buffer
local notes_dir = os.getenv("HOME") .. "/notes"
os.execute("mkdir -p " .. notes_dir)
local note_filename = vim.fn.getcwd():gsub("/", "%%")
local note_file = notes_dir .. "/" .. note_filename .. ".md"
local scratch_symlink = vim.fn.getcwd() .. "/scratch"
os.execute("touch " .. note_file)
os.execute("ln -sf " .. note_file .. " " .. scratch_symlink)

vim.api.nvim_create_user_command('S', ":edit " .. scratch_symlink, {})
vim.api.nvim_create_user_command('SS', ":split " .. scratch_symlink, {})
vim.api.nvim_create_user_command('SV', ":vsplit " .. scratch_symlink, {})
vim.api.nvim_create_user_command('ST', ":tabedit " .. scratch_symlink, {})

vim.cmd [[
command! -bang -nargs=* SG
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': '~/notes'}), <bang>0)
packadd cfilter
]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  group = augroup('HighlightYankGroup', { clear = true }),
  callback = function() vim.highlight.on_yank({ timeout = 70 }) end,
})

autocmd("BufRead", {
  group = augroup("FiletypeGroup", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "commit" and vim.bo.filetype ~= "rebase" and vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd.normal({ 'g`"', bang = true })
    end
  end,
})

autocmd("VimResized", {
  group = augroup("ResizeGroup", { clear = true }),
  callback = function()
    vim.cmd("wincmd =")
  end,
})

require("lazy").setup({
  spec = {
    {
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
      init = function() vim.g.startuptime_tries = 10 end,
    },
    {
      "HoNamDuong/hybrid.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("hybrid").setup({
          overrides = function(highlights, colors)
            highlights.Folded = {
              fg = colors.comment,
              bg = colors.line,
              italic = true,
            }
          end,
        })
        vim.cmd([[colorscheme hybrid]])
      end,
    },
    {
      "mbbill/undotree",
      init = function()
        vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
        vim.o.undofile = true
      end,
    },
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-rhubarb" },
    { "tpope/vim-abolish" },
    { "github/copilot.vim" },
    {
      "tpope/vim-fugitive",
      keys = { { "<leader>gg", ":tab G<cr>" } },
    },
    {
      "junegunn/gv.vim",
      dependencies = "tpope/vim-fugitive",
    },
    {
      "junegunn/fzf.vim",
      dependencies = "junegunn/fzf",
      init = function() vim.g.fzf_layout = { down = '40%' } end,
      keys = { { "<leader>ff", ":FZF<cr>" } },
    },
    {
      "pbogut/fzf-mru.vim",
      dependencies = "junegunn/fzf",
      init = function()
        vim.g.fzf_mru_relative = 1
        vim.g.fzf_mru_no_sort = 1
      end,
      keys = { { "<leader>fr", ":FZFMru<cr>" } },
    },
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        local gitsigns = require('gitsigns')
        gitsigns.setup {
          on_attach = function(bufnr)
            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
              else
                gitsigns.nav_hunk('next')
              end
            end)

            map('n', '[c', function()
              if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
              else
                gitsigns.nav_hunk('prev')
              end
            end)

            map('n', '<leader>hr', gitsigns.reset_hunk)
            map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            map('n', '<leader>hp', gitsigns.preview_hunk)
          end,
        }
      end,
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
    },
    {
      "stevearc/oil.nvim",
      opts = {
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            return name == 'Session.vim' or name == '.direnv'
          end,
        },
      },
      keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require('nvim-treesitter.configs').setup {
          modules = {},
          ignore_install = {},
          ensure_installed = { "c", "go", "lua", "vim", "markdown", "json", "jsonc", "nix", "bash", "terraform", "hcl", "sql", "typescript", "tsx", "javascript", "zig" },
          sync_install = false,
          auto_install = false,
          highlight = {
            enable = true,
            disable = function(_, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
          },
          indent = {
            enable = true,
            disable = { "python" },
          },
        }
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
      "AckslD/nvim-trevJ.lua",
      config = true,
      keys = { { "<leader>K", "<cmd>lua require('trevj').format_at_cursor()<cr>" } },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        { "saghen/blink.cmp" },
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {
            library = {
              -- See the configuration section for more details
              -- Load luvit types when the `vim.uv` word is found
              { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
          },
        },
      },
      opts = {
        servers = {
          bashls = {},
          gopls = {},
          jsonls = {},
          lua_ls = {},
          terraformls = {},
          yamlls = {},
        },
      },
      config = function(_, opts)
        local lspconfig = require("lspconfig")

        local on_attach = function(_, bufnr)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = bufnr })
        end

        for server, config in pairs(opts.servers) do
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          config.on_attach = on_attach
          lspconfig[server].setup(config)
        end

        autocmd('LspAttach', {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then return end

            if client:supports_method('textDocument/formatting') then
              autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
              })
            end
          end,
        })
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            section_separators = "",
            component_separators = "",
            globalstatus = true,
          },
          sections = {
            lualine_c = {},
            lualine_x = {
              function()
                return require('lsp-progress').progress()
              end,
            },
            lualine_y = {},
            lualine_z = {},
          },
          winbar = {
            lualine_a = { 'filename' },
            lualine_x = { 'encoding' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
          },
          inactive_winbar = {
            lualine_a = { 'filename' },
          },
        }
        autocmd('User', {
          group = augroup('lualine', { clear = true }),
          pattern = 'LspProgressStatusUpdated',
          callback = function() require('lualine').refresh() end,
        })
      end,
    },
    {
      'linrongbin16/lsp-progress.nvim',
      config = function()
        require("lsp-progress").setup({
          client_format = function(client_name, spinner, series_messages)
            if #series_messages == 0 then
              return nil
            end
            return {
              name = client_name,
              body = spinner .. " " .. table.concat(series_messages, ", "),
            }
          end,
          format = function(client_messages)
            local function stringify(name, msg)
              return msg and string.format("%s %s", name, msg) or name
            end

            local sign = ""
            local lsp_clients = vim.lsp.get_clients()
            local messages_map = {}
            for _, climsg in ipairs(client_messages) do
              messages_map[climsg.name] = climsg.body
            end

            if #lsp_clients > 0 then
              table.sort(lsp_clients, function(a, b)
                return a.name < b.name
              end)
              local builder = {}
              for _, cli in ipairs(lsp_clients) do
                if
                    type(cli) == "table"
                    and type(cli.name) == "string"
                    and string.len(cli.name) > 0
                then
                  if messages_map[cli.name] then
                    table.insert(
                      builder,
                      stringify(cli.name, messages_map[cli.name])
                    )
                  else
                    table.insert(builder, stringify(cli.name))
                  end
                end
              end
              if #builder > 0 then
                return sign .. " " .. table.concat(builder, ", ")
              end
            end
            return ""
          end,
        })
      end,
    },
    {
      "kristijanhusak/vim-dadbod-ui",
      dependencies = {
        { "tpope/vim-dadbod",                     lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
      },
      cmd = { "DBUI", "DBUIAddConnection" },
    },
    {
      'saghen/blink.compat',
      version = 'v2.*',
      lazy = true,
      opts = {},
    },
    {
      "saghen/blink.cmp",
      dependencies = "rafamadriz/friendly-snippets",
      version = "v0.*",
      opts = {
        keymap = {
          preset = "default",
          ['<C-j>'] = { 'select_next', 'fallback' },
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'normal'
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "dadbod", "gh_authors" },
          providers = {
            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            gh_authors = { name = "gh_authors", module = "blink.compat.source" },
          },
        },
        completion = {
          menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end },
          documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
        signature = { enabled = true },
      },
    },
  },
})
