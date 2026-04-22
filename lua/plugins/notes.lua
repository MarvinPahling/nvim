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
				invert_colors = "never",
				follow_cursor = true,

				dependencies_bin = {
					["tinymist"] = "tinymist",
					["websocat"] = vim.fn.exepath("socat") ~= "" and vim.fn.exepath("socat") or nil,
				},
				extra_args = nil,

				get_root = function(path_of_main_file)
					local root = os.getenv("TYPST_ROOT")
					if root then
						return root
					end
					return vim.fn.fnamemodify(path_of_main_file, ":p:h")
				end,

				get_main_file = function(path_of_buffer)
					return path_of_buffer
				end,
			})

			-- PDF preview with zathura
			-- Opens the compiled PDF in zathura (auto-reloads on file change)
			vim.api.nvim_create_user_command("OpenPdf", function()
				local filepath = vim.api.nvim_buf_get_name(0)
				if filepath:match("%.typ$") then
					local pdf_path = filepath:gsub("%.typ$", ".pdf")
					vim.system({ "zathura", pdf_path })
				end
			end, { desc = "Open typst PDF in zathura" })
		end,
	},
	{
		-- "meanderingprogrammer/render-markdown.nvim",
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		-- ---@module 'render-markdown'
		-- ---@type render.md.userconfig
		-- opts = {},
		-- config = function()
		-- 	local render = require("render-markdown")
		-- 	vim.keymap.set("n", "<leader>mr", function()
		-- 		render.toggle()
		-- 	end, { desc = "toggle [m]arkdown [r]ender" })
		--
		-- 	require("render-markdown").setup({
		-- 		code = {
		-- 			enabled = true,
		-- 			render_modes = false,
		-- 			sign = true,
		-- 			conceal_delimiters = true,
		-- 			language = true,
		-- 			position = "left",
		-- 			language_icon = true,
		-- 			language_name = true,
		-- 			language_info = true,
		-- 			language_pad = 0,
		-- 			disable_background = true,
		-- 			width = "full",
		-- 			left_margin = 0,
		-- 			left_pad = 0,
		-- 			right_pad = 0,
		-- 			min_width = 0,
		-- 			border = "hide",
		-- 			language_border = " ",
		-- 			language_left = "",
		-- 			language_right = "",
		-- 			above = "▄",
		-- 			below = "▀",
		-- 			inline = true,
		-- 			inline_left = "",
		-- 			inline_right = "",
		-- 			inline_pad = 0,
		-- 			highlight = "rendermarkdowncode",
		-- 			highlight_info = "rendermarkdowncodeinfo",
		-- 			highlight_language = nil,
		-- 			highlight_border = "rendermarkdowncodeborder",
		-- 			highlight_fallback = "rendermarkdowncodefallback",
		-- 			highlight_inline = "rendermarkdowncodeinline",
		-- 			style = "language",
		-- 		},
		-- 	})
		-- end,
	},
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "markdownpreviewtoggle", "markdownpreview", "markdownpreviewstop" },
	-- 	build = "cd app && yarn install",
	-- 	init = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- },
	{
		"ravibrock/spellwarn.nvim",
		event = "VeryLazy",
		config = function()
			local conf = {
				event = { -- event(s) to refresh diagnostics on
					"CursorHold",
					"InsertLeave",
					"TextChanged",
					"TextChangedI",
					"TextChangedP",
				},
				enable = true, -- enable diagnostics on startup
				ft_config = { -- spellcheck method: "cursor", "iter", or boolean
					alpha = false,
					help = false,
					lazy = false,
					lspinfo = false,
					mason = false,
				},
				ft_default = true, -- default option for unspecified filetypes
				max_file_size = nil, -- maximum file size to check in lines (nil for no limit)
				severity = { -- severity for each spelling error type (false to disable diagnostics for that type)
					spellbad = "WARN",
					spellcap = "HINT",
					spelllocal = "HINT",
					spellrare = "INFO",
				},
				suggest = false, -- show spelling suggestions in diagnostic message (works best with window-style message)
				num_suggest = 3, -- number of spelling suggestions shown in diagnostic message
				prefix = "possible misspelling(s): ", -- prefix for each diagnostic message
				diagnostic_opts = { severity_sort = true }, -- options for diagnostic display
			}

			require("spellwarn").setup(conf)
		end,
	},
}
