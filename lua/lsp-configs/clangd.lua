---@module 'lspconfig'
---@type lspconfig.Config
return {
	cmd = { "clangd" },
	init_options = {
		clangdFileStatus = true,
	},
}
