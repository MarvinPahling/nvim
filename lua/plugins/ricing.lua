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
	},
	{
		{
			"folke/zen-mode.nvim",
			opts = {
				window = {
					backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
					-- height and width can be:
					-- * an absolute number of cells when > 1
					-- * a percentage of the width / height of the editor when <= 1
					-- * a function that returns the width or the height
					width = 0.95, -- width of the Zen window
					-- height = 1, -- height of the Zen window
					-- by default, no options are changed for the Zen window
					-- uncomment any of the options below, or add other vim.wo options you want to apply
					options = {
						-- signcolumn = "no", -- disable signcolumn
						-- number = false, -- disable number column
						-- relativenumber = false, -- disable relative numbers
						-- cursorline = false, -- disable cursorline
						-- cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						-- list = false, -- disable whitespace characters
					},
				},
				plugins = {
					-- disable some global vim options (vim.o...)
					-- comment the lines to not apply the options
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
						-- you may turn on/off statusline in zen mode by setting 'laststatus'
						-- statusline will be shown only if 'laststatus' == 3
						laststatus = 0, -- turn off the statusline in zen mode
					},
					twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
					gitsigns = { enabled = false }, -- disables git signs
					tmux = { enabled = false }, -- disables the tmux statusline
					todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
				},
				-- callback where you can add custom code when the Zen window opens
				on_open = function(win) end,
				-- callback where you can add custom code when the Zen window closes
				on_close = function() end,
			},
			config = function()
				local keymap = vim.keymap
				keymap.set("n", "<leader>zz", "<cmd>ZenMode<CR>", { desc = "Toggle Zen-Mode" })
			end,
		},
		{
			"folke/twilight.nvim",
			opts = {
				dimming = {
					alpha = 0, -- amount of dimming
					-- we try to get the foreground from the highlight groups or fallback color
					color = { "Normal", "#ffffff" },
					term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
					inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
				},
				context = 5, -- amount of lines we will try to show around the current line
				treesitter = true, -- use treesitter when available for the filetype
				-- treesitter is used to automatically expand the visible text,
				-- but you can further control the types of nodes that should always be fully expanded
				expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
					"function",
					"method",
					"table",
					"if_statement",
				},
				exclude = {}, -- exclude these filetypes
			},
			config = function()
				vim.keymap.set("n", "<leader>zt", "<cmd>Twilight<cr>", { desc = "Toggle Twilight" })
				local twilight = require("twilight")
				twilight.setup({})
			end,
		},
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
}
