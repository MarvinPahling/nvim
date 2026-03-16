---@module 'lspconfig'
---@type lspconfig.Config
return {
	cmd = { "asm-lsp" },
	filetypes = { "asm", "nasm", "masm", "vmasm", "s", "S" },
	root_markers = { ".asm-lsp.toml", ".git" },
}
