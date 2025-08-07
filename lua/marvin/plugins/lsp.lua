return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		{ "mason-org/mason.nvim", version = "2.*" },
		{ "mason-org/mason-lspconfig.nvim", version = "2.*" },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"j-hui/fidget.nvim",
		"mfussenegger/nvim-jdtls",
		"mfussenegger/nvim-dap",
		"sudormrfbin/cheatsheet.nvim",
		{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				sh = { "shfmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				kotlint = { "ktlint" },
				xml = { "lemminx" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
		})
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		vim.lsp.config("*", { capabilities = capabilities })
		vim.lsp.config("ts_ls", {
			settings = {
				completions = {
					completeFunctionCalls = true,
				},
				typescript = {
					preferences = {
						includePackageJsonAutoImports = "on",
					},
				},
			},
		})
		vim.lsp.config("lua_ls", {
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
		})

		vim.lsp.config("pyright", {

			settings = {
				python = {
					analysis = {
						diagnosticMode = "workspace",
						typeCheckingMode = "basic",
					},
				},
			},
		})
		vim.lsp.config("kotlin_language_server", {
			settings = {
				kotlin = {
					compiler = {
						jvm = {
							target = "21",
						},
					},
				},
			},
		})

		require("fidget").setup({})
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
				-- java dev
				"jdtls",
				"kotlin_language_server",
				"gradle_ls",
				-- go
				"gopls",
				-- bash
				"bashls",
				"lemminx",
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
				"ktlint",
				"shfmt",
			},
		})
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true, desc = "Show line diagnostics" })
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "lsp show code actions" })
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "lsp rename symbol" })
		vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "lsp signature helper" })
		vim.keymap.set("n", "<leader>lth", vim.lsp.buf.typehierarchy, { desc = "lsp type hierarchy" })
		vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "lsp type definietion" })

		vim.diagnostic.config({
			virtual_lines = false,
		})
	end,
}
