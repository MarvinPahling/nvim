return {
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		opts = {
			style = "darker", -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = false, -- Show/hide background
			term_colors = true, -- Terminal color matching
			ending_tildes = false, -- Hide end-of-buffer tildes
			cmp_itemkind_reverse = false, -- CMP menu highlight ordering
			toggle_style_key = nil, -- Disable keybind or set it (e.g., "<leader>ts")
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
			code_style = {
				comments = "italic",
				keywords = "bold",
				functions = "bold",
				strings = "italic",
				variables = "none",
			},
			lualine = {
				transparent = false,
			},
			colors = {}, -- Custom colors
			highlights = {}, -- Custom highlight groups
			diagnostics = {
				darker = true,
				undercurl = true,
				background = true,
			},
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			require("onedark").load()
		end,
	},
}
