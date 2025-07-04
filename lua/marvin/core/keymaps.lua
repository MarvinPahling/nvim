vim.g.mapleader = " "

-- splits
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

-- system
vim.keymap.set("n", "<leader>qw", "<cmd>wa | qa<CR>", { desc = "Safe and close all buffers" })
vim.keymap.set("n", "<leader>qx", "<cmd>qa!<CR>", { desc = "Force quit all Buffers" })

-- file explorer
vim.keymap.set("n", "<leader>ee", "<cmd>Explore<CR>", { desc = "Open file explorer" })

-- regex
vim.keymap.set("x", "<leader>sr", function()
  vim.fn.feedkeys(":s/", "n")
end, { desc = "Find and replace current selection" })
vim.keymap.set("c", "<leader>cf", "\\(.*\\)", { desc = "Insert fighting one eyed kirby" })
vim.keymap.set("n", "<leader>sx", "<cmd>noh<CR>", { desc = "Clear search input" })

-- spell checking
vim.keymap.set("n", "<leader>le", "<cmd>setlocal spell spelllang=en_us<CR>", { desc = "Change language to English" })
vim.keymap.set("n", "<leader>ld", "<cmd>setlocal spell spelllang=de_de<CR>", { desc = "Change language to German" })

-- util
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Centers view after Ctrl-d" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Centers view after Ctrl-u" })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Centers view after "n" (next result)' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Centers view after "N" (previous result' })
