return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			local render = require("render-markdown")
			vim.keymap.set("n", "<leader>mr", function()
				render.toggle()
			end, { desc = "toggle [M]arkdown [R]ender" })
		end,
	},
}
