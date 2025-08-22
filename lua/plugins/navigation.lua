return {
	{
		{
			"echasnovski/mini.pick",
			version = "*",
			config = function()
				require("mini.pick").setup({
					-- Delays (in ms; should be at least 1)
					delay = {
						-- Delay between forcing asynchronous behavior
						async = 10,
						-- Delay between computation start and visual feedback about it
						busy = 50,
					},

					-- Keys for performing actions. See `:h MiniPick-actions`.
					mappings = {
						caret_left = "<Left>",
						caret_right = "<Right>",

						choose = "<CR>",
						choose_in_split = "<C-s>",
						choose_in_tabpage = "<C-t>",
						choose_in_vsplit = "<C-v>",
						choose_marked = "<M-CR>",

						delete_char = "<BS>",
						delete_char_right = "<Del>",
						delete_left = "<C-u>",
						delete_word = "<C-w>",

						mark = "<C-x>",
						mark_all = "<C-a>",

						move_down = "<C-n>",
						move_start = "<C-g>",
						move_up = "<C-p>",

						paste = "<C-r>",

						refine = "<C-Space>",
						refine_marked = "<M-Space>",

						scroll_down = "<C-f>",
						scroll_left = "<C-h>",
						scroll_right = "<C-l>",
						scroll_up = "<C-b>",

						stop = "<Esc>",

						toggle_info = "<S-Tab>",
						toggle_preview = "<Tab>",
					},

					-- General options
					options = {
						-- Whether to show content from bottom to top
						content_from_bottom = false,

						-- Whether to cache matches (more speed and memory on repeated prompts)
						use_cache = false,
					},

					-- Source definition. See `:h MiniPick-source`.
					source = {
						items = nil,
						name = nil,
						cwd = nil,

						match = nil,
						show = nil,
						preview = nil,

						choose = nil,
						choose_marked = nil,
					},

					-- Window related options
					window = {
						-- Float window config (table or callable returning it)
						config = nil,

						-- String to use as caret in prompt
						prompt_caret = "▏",

						-- String to use as prefix in prompt
						prompt_prefix = "> ",
					},
				})

				vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Open Pick" })
				vim.keymap.set("n", "<leader>fs", ":Pick grep_live<CR>", { desc = "Open Pick Search" })
				vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Open Pick Help" })
				vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Open Pick Buffers" })
			end,
		},
	},
	{
		{
			"echasnovski/mini.pick",
			version = "*",
			config = function()
				require("mini.pick").setup({
					-- Delays (in ms; should be at least 1)
					delay = {
						-- Delay between forcing asynchronous behavior
						async = 10,
						-- Delay between computation start and visual feedback about it
						busy = 50,
					},

					-- Keys for performing actions. See `:h MiniPick-actions`.
					mappings = {
						caret_left = "<Left>",
						caret_right = "<Right>",

						choose = "<CR>",
						choose_in_split = "<C-s>",
						choose_in_tabpage = "<C-t>",
						choose_in_vsplit = "<C-v>",
						choose_marked = "<M-CR>",

						delete_char = "<BS>",
						delete_char_right = "<Del>",
						delete_left = "<C-u>",
						delete_word = "<C-w>",

						mark = "<C-x>",
						mark_all = "<C-a>",

						move_down = "<C-n>",
						move_start = "<C-g>",
						move_up = "<C-p>",

						paste = "<C-r>",

						refine = "<C-Space>",
						refine_marked = "<M-Space>",

						scroll_down = "<C-f>",
						scroll_left = "<C-h>",
						scroll_right = "<C-l>",
						scroll_up = "<C-b>",

						stop = "<Esc>",

						toggle_info = "<S-Tab>",
						toggle_preview = "<Tab>",
					},

					-- General options
					options = {
						-- Whether to show content from bottom to top
						content_from_bottom = false,

						-- Whether to cache matches (more speed and memory on repeated prompts)
						use_cache = false,
					},

					-- Source definition. See `:h MiniPick-source`.
					source = {
						items = nil,
						name = nil,
						cwd = nil,

						match = nil,
						show = nil,
						preview = nil,

						choose = nil,
						choose_marked = nil,
					},

					-- Window related options
					window = {
						-- Float window config (table or callable returning it)
						config = nil,

						-- String to use as caret in prompt
						prompt_caret = "▏",

						-- String to use as prefix in prompt
						prompt_prefix = "> ",
					},
				})

				vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Open Pick" })
				vim.keymap.set("n", "<leader>fs", ":Pick grep_live<CR>", { desc = "Open Pick Search" })
				vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Open Pick Help" })
				vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Open Pick Buffers" })
			end,
		},
	},
	{
		"christoomey/vim-tmux-navigator",
	},
}
