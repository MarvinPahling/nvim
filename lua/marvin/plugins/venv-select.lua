return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	opts = {
		-- Your options go here
		-- path = "/opt/homebrew/Caskroom/miniconda/base/envs/",
		name = ".venv",
		auto_refresh = true,
		search_workspace = true,
		anaconda_base_path = "/opt/homebrew/Caskroom/miniconda/base/",
		anaconda_envs_path = "/opt/homebrew/Caskroom/miniconda/base/envs/",
		stay_on_this_version = true,
		-- name = "venv",
		-- auto_refresh = false
	},
	event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		-- Keymap to open VenvSelector to pick a venv.
		{ "<leader>vs", "<cmd>VenvSelect<cr>" },
		-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
	},
}
