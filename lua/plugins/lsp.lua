local lsp_configs = {
	tinymist = {
		settings = {
			formatterMode = "typstyle",
			exportPdf = "onType",
			semanticTokens = "disable",
		},
		on_attach = function(client, bufnr)
			vim.keymap.set("n", "<leader>tp", function()
				client:exec_cmd({

					title = "pin",

					command = "tinymist.pinMain",

					arguments = { vim.api.nvim_buf_get_name(0) },
				}, { bufnr = bufnr })
			end, { desc = "[T]inymist [P]in", noremap = true })

			vim.keymap.set("n", "<leader>tu", function()
				client:exec_cmd({

					title = "unpin",

					command = "tinymist.pinMain",

					arguments = { vim.v.null },
				}, { bufnr = bufnr })
			end, { desc = "[T]inymist [U]npin", noremap = true })
		end,
	},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				completion = {
					callSnippet = "Replace",
				},
				format = {
					enable = true,
					defaultConfig = {
						indent_style = "space",
						indent_size = "2",
					},
				},
			},
		},
	},
	clangd = {
		-- Minimal config - let .clangd file handle most settings
		cmd = { "clangd" },
		init_options = {
			clangdFileStatus = true,
		},
	},
	vhdl_ls = {
		-- VHDL language server configuration
		-- Looks for vhdl_ls.toml in project root
		settings = {},
	},
}

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
					json = { "biome" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					liquid = { "prettier" },
					sh = { "shfmt" },
					lua = { "stylua" },
					python = { "isort", "black" },
					kotlin = { "ktfmt" },
					typst = { "tinymist" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					vhdl = { "vsg" },
					sql = { "sleek" },
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
					"jsonls",
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
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true },

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
		"sophieforrest/processing.nvim",
		lazy = false,
		version = "^1",
	},
}
