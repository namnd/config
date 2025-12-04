vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "nv"
vim.wo.list = true
vim.o.listchars = "tab:| ,trail:·,eol:↵"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.wo.cursorline = true
vim.wo.number = true
vim.wo.signcolumn = "yes:1"
vim.wo.conceallevel = 0
vim.o.foldlevel = 10
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.sessionoptions:remove("folds") -- ignore folds when re-open session

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.g.markdown_fenced_languages = { "go", "python", "ruby", "vim", "c" }

vim.cmd([[
packadd cfilter
colorscheme namnd
]])

vim.pack.add({
	"https://github.com/tpope/vim-surround",
	"https://github.com/tpope/vim-repeat",
	"https://github.com/tpope/vim-obsession",
	"https://github.com/tpope/vim-rhubarb",
	"https://github.com/tpope/vim-abolish", -- crs, crc, cr-
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/junegunn/gv.vim", -- depends on vim-fugitive
	"https://github.com/junegunn/fzf.vim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/pbogut/fzf-mru.vim", -- depends on fzf.vim
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/AckslD/nvim-trevJ.lua", -- depends on treesitter
	"https://github.com/mbbill/undotree",
	"https://github.com/tweekmonster/startuptime.vim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/namnd/xai.nvim",
})

vim.g.fzf_layout = { down = "40%" }
vim.g.fzf_mru_relative = 1 -- only list files within current directory
vim.g.fzf_mru_no_sort = 1 -- keep list sorted by recency while typing

vim.lsp.enable({
	"bashls",
	"lua_ls",
	"gopls",
	"templ",
	"terraform-ls",
})

vim.diagnostic.config({ virtual_text = { current_line = true } })

require("nvim-autopairs").setup()

require("nvim-treesitter.configs").setup({
	modules = {},
	ignore_install = {},
	ensure_installed = {
		"bash",
		"go",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"markdown_inline",
		"nix",
		"terraform",
		"vim",
	},
	highlight = { enable = true },
	indent = { enable = true },
	sync_install = false,
	auto_install = false,
})

require("oil").setup({
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return name == "Session.vim" or name == ".direnv" or name:match("_templ.go" .. "$") ~= nil
		end,
	},
})

require("conform").setup({
	format_on_save = {},
	formatters_by_ft = {
		go = { lsp_format = "fallback" },
		lua = { "stylua" },
		terraform = { "terraform_fmt" },
		hcl = { "terraform_fmt" },
		["terraform-vars"] = { "terraform_fmt" },
		templ = { "templ" },
	},
})

---@diagnostic disable: param-type-mismatch
vim.api.nvim_create_autocmd("VimEnter", { -- require vim-obsession
	group = vim.api.nvim_create_augroup("ObsessionCheck", { clear = true }),
	callback = function()
		local status = vim.api.nvim_exec2([[ echo ObsessionStatus() ]], { output = true })
		if status["output"] ~= "[$]" then
			vim.api.nvim_command("silent! Obsession")
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYankGroup", { clear = true }),
	callback = function()
		vim.hl.on_yank({ timeout = 70 })
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("ResizeGroup", { clear = true }),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("FiletypeGroup", { clear = true }),
	pattern = "*",
	callback = function()
		if
			vim.bo.filetype ~= "commit"
			and vim.bo.filetype ~= "gitcommit"
			and vim.bo.filetype ~= "rebase"
			and vim.fn.line("'\"") > 1
			and vim.fn.line("'\"") <= vim.fn.line("$")
		then
			vim.cmd.normal({ 'g`"', bang = true })
		end
	end,
})

vim.o.complete = ".,o" -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noselect" -- add 'popup' for docs (sometimes)
vim.o.autocomplete = true
vim.o.pumheight = 7

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.api.nvim_create_user_command("S", require("notes").edit, {})

vim.keymap.set("v", "v", "$h", { noremap = true })
vim.keymap.set("n", "E", "ea", { noremap = true })
vim.keymap.set("n", "<leader>zz", ":tabclose<cr>", { noremap = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
vim.keymap.set("n", "<leader>gg", ":tab G<cr>", { noremap = true }) -- require vim-fugitive
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { noremap = true }) -- require oil.nvim
vim.keymap.set("n", "<leader>ff", ":FZF<cr>", { noremap = true }) -- require fzf.vim
vim.keymap.set("n", "<leader>fr", ":FZFMru<cr>", { noremap = true }) -- require fzf-mru
vim.keymap.set("n", "<leader>K", require("trevj").format_at_cursor, { noremap = true })
vim.keymap.set("n", "<leader>,", ":tabedit ~/.config/nvim/init.lua<cr>", { noremap = true })
vim.keymap.set("n", "<leader>/", ":tabedit ~/.config/home-manager/home.nix<cr>", { noremap = true })
vim.keymap.set("n", "]c", '<cmd>lua require("gitsigns").nav_hunk("next")<cr>', { noremap = true })
vim.keymap.set("n", "[c", '<cmd>lua require("gitsigns").nav_hunk("prev")<cr>', { noremap = true })
vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { noremap = true })
vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { noremap = true })
vim.keymap.set("n", "<leader>rp", "yiwy<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("v", "<leader>rp", "y<esc>:%s/<C-r>+//gc<left><left><left>", { noremap = true })
vim.keymap.set("n", "<leader>2", function() -- toggle qflist window
	if vim.fn.getqflist({ winid = 0 }).winid == 0 then
		vim.api.nvim_command("copen")
	else
		vim.api.nvim_command("cclose")
	end
end, { noremap = true })
