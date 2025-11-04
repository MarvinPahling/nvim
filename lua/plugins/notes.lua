return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
		config = function()
			require("typst-preview").setup({
				debug = true,
				open_cmd = nil,
				port = 42069,

				-- Setting this to 'always' will invert black and white in the preview
				-- Setting this to 'auto' will invert depending if the browser has enable
				-- dark mode
				-- Setting this to '{"rest": "<option>","image": "<option>"}' will apply
				-- your choice of color inversion to images and everything else
				-- separately.
				invert_colors = "never",

				-- Whether the preview will follow the cursor in the source file
				follow_cursor = true,

				-- Provide the path to binaries for dependencies.
				-- Setting this will skip the download of the binary by the plugin.
				-- Warning: Be aware that your version might be older than the one
				-- required.
				dependencies_bin = {
					["tinymist"] = "tinymist",
					["websocat"] = vim.fn.exepath("socat") ~= "" and vim.fn.exepath("socat") or nil,
				},

				-- A list of extra arguments (or nil) to be passed to previewer.
				-- For example, extra_args = { "--input=ver=draft", "--ignore-system-fonts" }
				extra_args = nil,

				-- This function will be called to determine the root of the typst project
				get_root = function(path_of_main_file)
					local root = os.getenv("TYPST_ROOT")
					if root then
						return root
					end
					return vim.fn.fnamemodify(path_of_main_file, ":p:h")
				end,

				-- This function will be called to determine the main file of the typst
				-- project.
				get_main_file = function(path_of_buffer)
					return path_of_buffer
				end,
			})
		end,
	},
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
