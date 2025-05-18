return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		vim.keymap.set(
			"n",
			"<leader>fc",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "Find string under cursor in cwd" }
		)
		vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Fuzzy find commands" })
		vim.keymap.set("n", "<leader>ft", "<cmd>Telescope filetypes<cr>", { desc = "Change filetype" })

		vim.keymap.set("n", "<leader>ls", "<cmd>Telescope spell_suggest<cr>", { desc = "Show spell suggest" })

		vim.keymap.set("n", "<leader>vc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
		vim.keymap.set("n", "<leader>vbc", "<cmd>Telescope git_bcommits<cr>", { desc = "Git buffer commits" })
		vim.keymap.set("n", "<leader>vs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
		vim.keymap.set("n", "<leader>vp", "<cmd>Telescope git_stash<cr>", { desc = "Git stash" })
		vim.keymap.set("n", "<leader>vf", "<cmd>Telescope git_files<cr>", { desc = "Git files" })
	end,
}
