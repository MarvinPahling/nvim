---@diagnostic disable: missing-fields
return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {},
		config = function()
			vim.opt_local.conceallevel = 2
			local obsidan = require("obsidian")

			vim.keymap.set("n", "<leader>onn", "<cmd>Obsidian new<cr>", { desc = "New note" })
			vim.keymap.set("n", "<leader>ont", "<cmd>Obsidian new_from_template<cr>", { desc = "New Template note" })
			vim.keymap.set("n", "<leader>off", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch" })
			vim.keymap.set("n", "<leader>oll", "<cmd>ObsidianFollowLink<cr>", { desc = "Follow link" })
			vim.keymap.set("n", "<leader>olb", "<cmd>ObsidianBacklinks<cr>", { desc = "Show backlinks" })
			vim.keymap.set("v", "<leader>oln", "<cmd>ObsidianLinkNew<cr>", { desc = "Show backlinks" })
			vim.keymap.set("n", "<leader>ott", "<cmd>ObsidianTags<cr>", { desc = "Search tags" })
			vim.keymap.set("n", "<leader>odd", "<cmd>ObsidianDailies<cr>", { desc = "Daily notes" })
			vim.keymap.set("n", "<leader>odn", "<cmd>ObsidianToday<cr>", { desc = "Today" })
			vim.keymap.set("n", "<leader>ody", "<cmd>ObsidianTomorrow<cr>", { desc = "Tomorrow " })
			vim.keymap.set("n", "<leader>odt", "<cmd>ObsidianYesterday<cr>", { desc = "Yesterday" })
			vim.keymap.set("n", "<leader>oct", "<cmd>ObsidianToggleCheckbox<cr>", { desc = "Toggle Checkbox" })
			obsidan.setup({
				-- A list of workspace names, paths, and configuration overrides.
				-- If you use the Obsidian app, the 'path' of a workspace should generally be
				-- your vault root (where the `.obsidian` folder is located).
				-- When obsidian.nvim is loaded by your plugin manager, it will automatically set
				-- the workspace to the first workspace in the list whose `path` is a parent of the
				-- current markdown file being edited.
				workspaces = {
					{
						name = "personal",
						path = "~/vaults/personal",
					},
				},

				notes_subdir = "notes",
				log_level = vim.log.levels.INFO,

				daily_notes = {
					folder = "notes/daily",
					date_format = "%Y-%m-%d",
					alias_format = "%B %-d, %Y",
					default_tags = { "daily-notes" },
					template = nil,
					workdays_only = false,
				},

				completion = {
					nvim_cmp = true,
					blink = false,
					min_chars = 2,
				},
				mappings = {},
				new_notes_location = "notes",
				-- Either 'wiki' or 'markdown'.
				preferred_link_style = "wiki",
				-- Optional, boolean or a function that takes a filename and returns a boolean.
				-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
				disable_frontmatter = false,

				-- Optional, for templates (see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Using-templates)
				templates = {
					folder = "templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
					-- A map for custom variables, the key should be the variable and the value a function
					substitutions = {},
				},

				-- Sets how you follow URLs
				---@param url string
				follow_url_func = function(url)
					vim.ui.open(url)
					-- vim.ui.open(url, { cmd = { "firefox" } })
				end,

				-- Sets how you follow images
				---@param img string
				follow_img_func = function(img)
					vim.ui.open(img)
					-- vim.ui.open(img, { cmd = { "loupe" } })
				end,

				-- Optional, set to true to force ':Obsidian open' to bring the app to the foreground.
				open_app_foreground = false,

				picker = {
					name = "telescope.nvim",
				},

				-- Optional, sort search results by "path", "modified", "accessed", or "created".
				-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
				-- that `:Obsidian quick_switch` will show the notes sorted by latest modified time
				sort_by = "modified",
				sort_reversed = true,

				-- Set the maximum number of lines to read from notes on disk when performing certain searches.
				search_max_lines = 1000,

				-- Optional, determines how certain commands open notes. The valid options are:
				-- 1. "current" (the default) - to always open in the current window
				-- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
				-- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
				open_notes_in = "current",
				callbacks = {},

				-- Optional, configure additional syntax highlighting / extmarks.
				-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
				ui = {
					enable = true, -- set to false to disable all additional syntax features
					update_debounce = 200, -- update delay after a text change (in milliseconds)
					max_file_length = 5000, -- disable UI features for files with more than this many lines
					-- Define how various check-boxes are displayed
					checkboxes = {
						-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
						[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
						["x"] = { char = "", hl_group = "ObsidianDone" },
						[">"] = { char = "", hl_group = "ObsidianRightArrow" },
						["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
						["!"] = { char = "", hl_group = "ObsidianImportant" },
						-- Replace the above with this if you don't have a patched font:
						-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
						-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

						-- You can also add more custom ones...
					},
					-- Use bullet marks for non-checkbox lists.
					bullets = { char = "•", hl_group = "ObsidianBullet" },
					external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					-- Replace the above with this if you don't have a patched font:
					-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
					reference_text = { hl_group = "ObsidianRefText" },
					highlight_text = { hl_group = "ObsidianHighlightText" },
					tags = { hl_group = "ObsidianTag" },
					block_ids = { hl_group = "ObsidianBlockID" },
					hl_groups = {
						-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
						ObsidianTodo = { bold = true, fg = "#f78c6c" },
						ObsidianDone = { bold = true, fg = "#89ddff" },
						ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
						ObsidianTilde = { bold = true, fg = "#ff5370" },
						ObsidianImportant = { bold = true, fg = "#d73128" },
						ObsidianBullet = { bold = true, fg = "#89ddff" },
						ObsidianRefText = { underline = true, fg = "#c792ea" },
						ObsidianExtLinkIcon = { fg = "#c792ea" },
						ObsidianTag = { italic = true, fg = "#89ddff" },
						ObsidianBlockID = { italic = true, fg = "#89ddff" },
						ObsidianHighlightText = { bg = "#75662e" },
					},
				},

				-- Optional, customize how note IDs are generated given an optional title.
				---@param title string|?
				---@return string
				note_id_func = function(title)
					local datetime = os.date("%Y-%m-%d-%H%M") -- e.g., "2025-05-18-1405"
					local suffix = ""
					if title ~= nil then
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return datetime .. "-" .. suffix
				end,
				-- Specify how to handle attachments.
				attachments = {
					-- The default folder to place images in via `:Obsidian paste_img`.
					-- If this is a relative path it will be interpreted as relative to the vault root.
					-- You can always override this per image by passing a full path to the command instead of just a filename.
					img_folder = "assets/imgs", -- This is the default

					-- A function that determines default name or prefix when pasting images via `:Obsidian paste_img`.
					---@return string
					img_name_func = function()
						-- Prefix image names with timestamp.
						return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
					end,

					-- A function that determines the text to insert in the note when pasting an image.
					-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
					-- This is the default implementation.
					---@param client obsidian.Client
					---@param path obsidian.Path the absolute path to the image file
					---@return string
					img_text_func = function(client, path)
						path = client:vault_relative_path(path) or path
						return string.format("![%s](%s)", path.name, path)
					end,
				},

				-- See https://github.com/obsidian-nvim/obsidian.nvim/wiki/Notes-on-configuration#statusline-component
				statusline = {
					enabled = true,
					format = "{{properties}} properties {{backlinks}} backlinks {{words}} words {{chars}} chars",
				},
			})
		end,
	},
	{
		"3rd/diagram.nvim",
		dependencies = {
			"3rd/image.nvim",
		},
		opts = { -- you can just pass {}, defaults below
			events = {
				render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
				clear_buffer = { "BufLeave" },
			},
			config = function()
				require("diagram").setup({
					integrations = {
						require("diagram.integrations.markdown"),
						require("diagram.integrations.neorg"),
					},
					renderer_options = {
						mermaid = {
							background = "transparent", -- nil | "transparent" | "white" | "#hex"
							theme = "forest", -- nil | "default" | "dark" | "forest" | "neutral"
							scale = 1, -- nil | 1 (default) | 2  | 3 | ...
							width = 800, -- nil | 800 | 400 | ...
							height = 600, -- nil | 600 | 300 | ...
						},
						plantuml = {
							charset = nil,
						},
						d2 = {
							theme_id = nil,
							dark_theme_id = nil,
							scale = nil,
							layout = nil,
							sketch = nil,
						},
						gnuplot = {
							size = nil, -- nil | "800,600" | ...
							font = nil, -- nil | "Arial,12" | ...
							theme = nil, -- nil | "light" | "dark" | custom theme string
						},
					},
				})
			end,
		},
	},
	{
		"3rd/image.nvim",
		build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		opts = {
			processor = "magick_cli",
		},
	},
	-- {
	-- 	"jmbuhr/otter.nvim",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	opts = {},
	-- },
}
