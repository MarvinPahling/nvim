return {
	--- Platform IO
	{
		"anurag3301/nvim-platformio.lua",
		dependencies = {
			{ "akinsho/nvim-toggleterm.lua" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			vim.keymap.set("n", "<leader>pi", "<cmd>Pioinit<CR>", { desc = "Open new project" })
			vim.keymap.set("n", "<leader>pr", "<cmd>Piorun<CR>", { desc = "Run the programm" })
			vim.keymap.set("n", "<leader>pm", "<cmd>Piomonitor<CR>", { desc = "Monitor the programm" })
		end,
	},
	--- rust
	{
		"simrat39/rust-tools.nvim",
		config = function()
			vim.keymap.set("n", "<leader>rr", "<cmd>RustRun<CR>", { desc = "Run Rust Programm" })
		end,
	},
}
