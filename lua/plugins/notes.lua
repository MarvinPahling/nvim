return {
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},
	-- {
	-- 	"al-kot/typst-preview.nvim",
	-- 	config = function()
	-- 		require("typst-preview").setup({
	-- 			preview = {
	-- 				max_width = 80, -- Maximum width of the preview window (columns)
	-- 				ppi = 144, -- The PPI (pixels per inch) to use for PNG export (high value will affect the performance)
	-- 				position = "right", -- The position of the preview window relative to the code window
	-- 			},
	-- 			statusline = {
	-- 				enabled = true, -- Show statusline
	-- 				compile = { -- Last compilation status
	-- 					ok = { icon = "", color = "#b8bb26" },
	-- 					ko = { icon = "", color = "#fb4943" },
	-- 				},
	-- 				page_count = { -- Page count
	-- 					color = "#d5c4e1",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
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
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
