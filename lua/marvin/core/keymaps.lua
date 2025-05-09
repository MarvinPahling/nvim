vim.g.mapleader = " "

vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<leader>qw", "<cmd>wa | qa<CR>", { desc = "Safe and close all buffers" })
vim.keymap.set("n", "<leader>qx", "<cmd>qa!<CR>", { desc = "Force quit all Buffers" })
vim.keymap.set("n", "<leader>ee", "<cmd>Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>sx", "<cmd>noh<CR>", { desc = "Clear search input" })
vim.keymap.set("x", "<leader>sr", function()
	vim.fn.feedkeys(":s/", "n")
end, { desc = "Find and replace current selection" })
vim.keymap.set("c", "<leader>cf", "\\(.*\\)", { desc = "Insert fighting one eyed kirby" })
