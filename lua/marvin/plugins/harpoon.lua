return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local keymap = vim.keymap
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		require("telescope").load_extension("harpoon")
		keymap.set("n", "<leader>ha", mark.add_file, { desc = "mark current file" })
		keymap.set("n", "<leader>hr", mark.rm_file, { desc = "remove current file" })
		keymap.set("n", "<leader>hx", mark.clear_all, { desc = "remove all file" })
		keymap.set("n", "<leader>hh", "<cmd>Telescope harpoon marks<cr>")
		keymap.set("n", "<C-h>", ui.nav_next)
		keymap.set("n", "<C-l>", ui.nav_prev)
	end,
}
