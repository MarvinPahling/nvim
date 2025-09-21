-- OPTIONS
vim.cmd("let g:netrw_liststyle = 3")
local opt = vim.opt

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.relativenumber = true
opt.number = true
opt.wrap = true
opt.linebreak = true

opt.ignorecase = true
opt.smartcase = true
opt.cursorline = false
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
vim.g.mapleader = " "
-- KEYMAPS
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
vim.keymap.set("n", "<leader>sx", "<cmd>noh<CR>", { desc = "Clear search input" })

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

-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" }, { import = "themes.active" } }, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
