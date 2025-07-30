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

			require("render-markdown").setup({
				code = {
					enabled = true,
					render_modes = false,
					sign = true,
					conceal_delimiters = true,
					language = true,
					position = "left",
					language_icon = true,
					language_name = true,
					language_info = true,
					language_pad = 0,
					disable_background = true,
					width = "full",
					left_margin = 0,
					left_pad = 0,
					right_pad = 0,
					min_width = 0,
					border = "hide",
					language_border = " ",
					language_left = "",
					language_right = "",
					above = "▄",
					below = "▀",
					inline = true,
					inline_left = "",
					inline_right = "",
					inline_pad = 0,
					highlight = "RenderMarkdownCode",
					highlight_info = "RenderMarkdownCodeInfo",
					highlight_language = nil,
					highlight_border = "RenderMarkdownCodeBorder",
					highlight_fallback = "RenderMarkdownCodeFallback",
					highlight_inline = "RenderMarkdownCodeInline",
					style = "language",
				},
			})
		end,
	},
}
