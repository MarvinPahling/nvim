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
vim.keymap.set("n", "<leader>vpg", function()
	vim.pack.get()
end, { desc = "vim.pack: update all plugins" })
vim.keymap.set("n", "<leader>vpu", function()
	vim.pack.update()
end, { desc = "vim.pack: update all plugins" })

vim.keymap.set("n", "<leader>tp", "<cmd>LspTinymistPinMain<CR>", { desc = "Typst Pin" })

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/folke/trouble.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	"https://github.com/AlexandrosAlexiou/kotlin.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
  "https://github.com/nxuv/just.nvim",
  "https://github.com/carderne/pi-nvim.git"
})

-- Theme
require("vague").setup({
	transparent = true,
	bold = true,
	italic = false,
})
vim.cmd.colorscheme("vague")

-- LSP
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
})
require("lazydev").setup()
pcall(require, "lspconfig")

if vim.fn.exists(":LspRestart") == 0 then
	vim.api.nvim_create_user_command("LspRestart", function()
		for _, client in ipairs(vim.lsp.get_clients()) do
			client:stop(true)
		end
		vim.cmd.edit()
	end, { desc = "Restart all LSP clients" })
end

if vim.fn.exists(":LspStop") == 0 then
	vim.api.nvim_create_user_command("LspStop", function()
		for _, client in ipairs(vim.lsp.get_clients()) do
			client:stop(true)
		end
	end, { desc = "Stop all LSP clients" })
end

if vim.fn.exists(":LspStart") == 0 then
	vim.api.nvim_create_user_command("LspStart", function()
		vim.cmd.edit()
	end, { desc = "Start LSP clients for current buffer" })
end
require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
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

-- =========================================================================
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
		makefile = { "mbake" },
		yaml = { "yamlfmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 5000,
	},
})

require("oil").setup({
	watch_for_changes = true,
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "<leader>ee", ":Oil<CR>", { desc = "Open file explorer" })

-- telescope
local telescope = require("telescope")
telescope.load_extension("ui-select")
-- telescope.load_extension("fzy_native")
telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"", -- top
			"", -- right
			"", -- bottom
			"", -- left
			"", -- top-left
			"", -- top-right
			"", -- bottom-right
			"", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
})
local builtin = require("telescope.builtin")
telescope.load_extension("ui-select")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Telescope show manpage" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope show diagnostics" })

vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, { desc = "Go To Implementation" })
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, { desc = "Go To Definition" })
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, { desc = "Go To References" })
vim.keymap.set("n", "<leader>gs", builtin.lsp_document_symbols, { desc = "Go To symbols" })
vim.keymap.set("n", "<leader>gws", builtin.lsp_dynamic_workspace_symbols, { desc = "Go To Workspace sym" })
vim.keymap.set("n", "<leader>gci", builtin.lsp_incoming_calls, { desc = "Go To Call Incomming" })
vim.keymap.set("n", "<leader>gco", builtin.lsp_outgoing_calls, { desc = "Go To Call Outgoing" })

-- require("kotlin").setup({
-- 	jvm_args = {
-- 		"-Xmx4g",
-- 	},
-- 	-- build_tool = "gradle",
-- 	-- jdk_for_symbol_resolution = os.getenv("JAVA_HOME"),
-- 	inlay_hints = {
-- 		enabled = true, -- Enable inlay hints (auto-enable on LSP attach)
-- 		parameters = true, -- Show parameter names
-- 		parameters_compiled = true, -- Show compiled parameter names
-- 		parameters_excluded = false, -- Show excluded parameter names
-- 		types_property = true, -- Show property types
-- 		types_variable = true, -- Show local variable types
-- 		function_return = true, -- Show function return types
-- 		function_parameter = true, -- Show function parameter types
-- 		lambda_return = true, -- Show lambda return types
-- 		lambda_receivers_parameters = true, -- Show lambda receivers/parameters
-- 		value_ranges = true, -- Show value ranges
-- 		kotlin_time = true, -- Show kotlin.time warnings
-- 	},
-- 	file_templates = {
-- 		enabled = false,
-- 	},
-- })

vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
		typstExtraArgs = { "main.typ" },
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"svelte",
		"markdown",
		"lua",
		"rust",
		"typst",
		"typescript",
		"javascript",
		"c",
		"cpp",
		"glsl",
		"zig",
		"python",
		"typescriptreact",
		"react",
	},
	callback = function()
		vim.treesitter.start()
	end,
})
local just = require("just")
just.setup({
    fidget_message_limit = 32, -- limit for length of fidget progress message
    open_qf_on_error = true,   -- opens quickfix when task fails
    open_qf_on_run = true,     -- opens quickfix when running `run` task (`:JustRun`)
    open_qf_on_any = false;    -- opens quickfix when running any task (overrides other open_qf options)
    autoscroll_qf = true,      -- automatically scroll quickfix window on output
    register_commands = true,  -- if set to true then commands (:Just*) will be registered
    notify = vim.notify,       -- what to use to show messages/errors
})

vim.keymap.set("n", "<leader>fj", just.run_task_select, { desc = "Telescope Just" })

require("pi-nvim").setup({
  socket_path = nil, 
  set_default_keymaps = true,
})

vim.keymap.set("n", "<leader>pp", ":PiSend<CR>")
vim.keymap.set("n", "<leader>pf", ":PiSendFile<CR>")
vim.keymap.set("v", "<leader>ps", ":PiSendSelection<CR>")
vim.keymap.set("n", "<leader>pb", ":PiSendBuffer<CR>")
vim.keymap.set("n", "<leader>pi", ":PiPing<CR>")
