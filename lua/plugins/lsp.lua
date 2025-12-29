-- Dynamically load all LSP configs from lua/lsp-configs/
local lsp_configs = {}
local config_path = vim.fn.stdpath("config") .. "/lua/lsp-configs"
local config_files = vim.fn.glob(config_path .. "/*.lua", false, true)

for _, file in ipairs(config_files) do
	local config_name = vim.fn.fnamemodify(file, ":t:r")
	lsp_configs[config_name] = require("lsp-configs." .. config_name)
end
---@type blink.cmp.WindowBorder
local blink_window_border = "bold"

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			{ "mason-org/mason.nvim", version = "2.*" },
			{ "mason-org/mason-lspconfig.nvim", version = "2.*" },
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- add filetype for some files
			vim.filetype.add({
				pattern = {
					["compose.*%.ya?ml"] = "yaml.docker-compose",
					["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
					["*.typ"] = "typst",
					["*.puml"] = "plantuml",
				},
			})
			-- formatting
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "biome" },
					typescript = { "biome" },
					javascriptreact = { "biome" },
					typescriptreact = { "biome" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					json5 = { "prettier" },
					jsonc = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					liquid = { "prettier" },
					sh = { "shfmt" },
					lua = { "stylua" },
					python = { "isort", "black" },
					java = { "palantir_java_format" },
					kotlin = { "ktfmt" },
					typst = { "tinymist" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					vhdl = { "vsg" },
					sql = { "sqlfluff" },
				},
				formatters = {
					biome = {
						command = "biome",
						args = {
							"format",
							"--stdin-file-path",
							"$FILENAME",
						},
						stdin = true,
					},
					prettypst = {
						command = "prettypst",
						args = { "--style=otbs", "$FILENAME" },
						stdin = false,
					},
					vsg = {
						command = "vsg",
						args = {
							"--fix",
							"--style",
							"jcl",
							"$FILENAME",
						},
						stdin = false,
						exit_codes = { 0, 1, 2 },
					},
					palantir_java_format = {
						command = "./mvnw",
						args = { "spotless:apply", "-q" },
						stdin = false,
						cwd = require("conform.util").root_file({ "mvnw", "pom.xml" }),
					},
					sqlfluff = {
						command = "sqlfluff",
						args = { "fix", "--force", "-" },
						stdin = true,
					},
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				},
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {
					-- web
					"html",
					"cssls",
					"tailwindcss",
					"ts_ls",
					-- containerisation and ci/cd
					"docker_compose_language_service",
					"dockerls",
					-- "gh-actions-language-server",
					"nginx_language_server",
					-- lua
					"lua_ls",
					-- python
					"pyright",
					-- c/c++
					"clangd",
					-- rust
					"rust_analyzer",
					-- go
					"gopls",
					-- bash
					"bashls",
					-- xml
					"lemminx",
					-- kotlin
					"kotlin_language_server",
					-- typst
					"tinymist",
					-- vhdl
					"vhdl_ls",
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"eslint_d",
					"biome",
					"black",
					"isort",
					"clang-format",
					"stylua",
					"shfmt",
					"ktfmt",
					"vsg",
					"sqlfluff",
				},
			})

			-- register all configs using the vim.lsp api
			for lsp_name, config in pairs(lsp_configs) do
				vim.lsp.config(lsp_name, config)
			end
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				"nvim-lspconfig",
			},
		},
		notify = false,
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = "luasnip" },
			term = { completion = { ghost_text = { enabled = true } } },
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },

				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				accept = { auto_brackets = { enabled = false } },
				documentation = { auto_show = true, window = { border = blink_window_border } },
				ghost_text = { enabled = false, show_with_menu = true, show_with_selection = true },
				keyword = { range = "full" },
				menu = { auto_show = true, border = blink_window_border },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true, window = { border = blink_window_border } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			treesitter.setup({
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							vim.notify(
								"File larger than 100KB treesitter disabled for performance",
								vim.log.levels.WARN,
								{ title = "Treesitter" }
							)
							return true
						end
					end,
				},
				indent = { enable = true },
				autotag = {
					enable = true,
				},
				ensure_installed = {
					"json",
					"java",
					"kotlin",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"prisma",
					"markdown",
					"markdown_inline",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"regex",
					"c",
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")
			ls.setup({ enable_autosnippets = true })
			require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/snippets" } })
			vim.keymap.set("i", "<C-e>", function()
				ls.expand_or_jump()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-J>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-K>", function()
				ls.jump(-1)
			end, { silent = true })
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end,
	},
}
