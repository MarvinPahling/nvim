return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "folke/noice.nvim", "yavorski/lualine-macro-recording.nvim" },
	config = function()
		vim.opt.laststatus = 0
		local lualine = require("lualine")
		lualine.setup({

			options = {
				icons_enabled = true,
				theme = "vague",
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
}
