-- OPTIONS
vim.g.mapleader = " "

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = true
vim.opt.linebreak = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
-- splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- system
vim.keymap.set("n", "<leader>qw", "<cmd>wa | qa<CR>", { desc = "Safe and close all buffers" })
vim.keymap.set("n", "<leader>qx", "<cmd>qa!<CR>", { desc = "Force quit all Buffers" })

-- regex
vim.keymap.set("x", "<leader>sr", function()
	vim.fn.feedkeys(":s/", "n")
end, { desc = "Find and replace current selection" })
vim.keymap.set("c", "<leader>cf", "\\(.*\\)", { desc = "Insert fighting one eyed kirby" })

-- programming
vim.keymap.set("i", "<C-7>", "[]<esc>i", { desc = "Insert []" })
vim.keymap.set("i", "<C-8>", "{}<esc>i", { desc = "Insert {}" })
vim.keymap.set("i", "<C-9>", "()<esc>i", { desc = "Insert ()" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- spell checking
vim.keymap.set("n", "<leader>le", "<cmd>setlocal spell spelllang=en_us<CR>", { desc = "Change language to English" })
vim.keymap.set("n", "<leader>ld", "<cmd>setlocal spell spelllang=de_de<CR>", { desc = "Change language to German" })

-- util
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Centers view after Ctrl-d" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Centers view after Ctrl-u" })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Centers view after "n" (next result)' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Centers view after "N" (previous result' })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "open line diagnostic" })

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/stevearc/conform.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})
-- Theme
require("vague").setup({
	transparent = false,
	bold = true,
	italic = false,
})
vim.cmd.colorscheme("vague")

-- LSP
require("mason").setup()
require("mason-lspconfig").setup()
require("lazydev").setup()
require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust" },
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<Tab>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				else
					return cmp.select_and_accept()
				end
			end,
			"snippet_forward",
			"fallback",
		},
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},
})
require("conform").setup({
	formatters_by_ft = {
		javascript = { "biome" },
		typescript = { "biome" },
		javascriptreact = { "biome" },
		typescriptreact = { "biome" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		sh = { "shfmt" },
		lua = { "stylua" },
		python = { "ruff" },
		java = { "palantir_java_format" },
		kotlin = { "ktfmt" },
		typst = { "tinymist" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		vhdl = { "vsg" },
		sql = { "sqlfluff" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 5000,
	},
})

require("oil").setup({
	watch_for_changes = true,
})

vim.keymap.set("n", "<leader>ee", ":Oil<CR>", { desc = "Open file explorer" })
