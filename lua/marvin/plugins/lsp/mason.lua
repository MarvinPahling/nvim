return {
	"williamboman/mason.nvim",
	branch = "v1.x",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim", branch = "v1.x" },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({})

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"html",
				"cssls",
				"jsonls",
				"tailwindcss",
				"ts_ls",
				"sqls",
				"docker_compose_language_service",
				"dockerls",
				"lua_ls",
				"basedpyright",
				"clangd",
				"rust_analyzer",
				"zls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
			},
		})
	end,
}
