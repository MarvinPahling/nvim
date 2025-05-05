return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "folke/noice.nvim", "yavorski/lualine-macro-recording.nvim" },
	config = function()
		local lualine = require("lualine")
		-- configure lualine with modified theme
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename", { "macro_recording", "%S" } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
