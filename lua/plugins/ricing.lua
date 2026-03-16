return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "folke/noice.nvim", "yavorski/lualine-macro-recording.nvim" },
		config = function()
			vim.opt.laststatus = 0
			local lualine = require("lualine")
			lualine.setup({

				options = {
					icons_enabled = true,
					theme = "auto",
					section_separators = "",
					component_separators = "",
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = false,
					globalstatus = false,
					refresh = {
						statusline = 250,
						tabline = 250,
						winbar = 250,
					},
				},
				sections = {},
				inactive_sections = {},
				tabline = {},
				winbar = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diagnostics" },
					lualine_y = { "encoding", "fileformat", "filetype", "lsp_status" },
					lualine_z = { "filename" },
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = { "filename" },
				},
				extensions = {},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {},
	},
	{
		"echasnovski/mini.icons",
		version = "*",
		opt = {
			-- Icon style: 'glyph' or 'ascii'
			style = "glyph",

			-- Customize per category. See `:h MiniIcons.config` for details.
			default = {},
			directory = {},
			extension = {},
			file = {},
			filetype = {},
			lsp = {},
			os = {},

			-- Control which extensions will be considered during "file" resolution
			use_file_extension = function(ext, file)
				return true
			end,
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = false, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
}
