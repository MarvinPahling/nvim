return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			automatic_installation = true,
			ensure_installed = {
				"html",
				"emmet_ls",
				"cssls",
				"jsonls",
				"tailwindcss",
				"ts_ls",
				"angularls",
				"graphql",
				"prismals",
				"sqls",
				"docker_compose_language_service",
				"dockerls",
				-- "nginx_language_server",
				"lua_ls",
				"basedpyright",
				"bashls",
				"clangd",
				"rust_analyzer",
				"zls", -- Zig
				"kotlin-language-server",
				-- "java_language_server",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				"eslint_d",
			},
		})
	end,
}
