return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			extensions = {
				file_browser = {
					theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						["i"] = {
							-- your custom insert mode mappings
						},
						["n"] = {
							-- your custom normal mode mappings
						},
					},
				},
			},
		})
	end,
	vim.keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", { desc = "open file explorer" }),
	vim.keymap.set(
		"n",
		"<space>fb",
		"<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
		{ desc = "open buffer file explorer" }
	),
}
