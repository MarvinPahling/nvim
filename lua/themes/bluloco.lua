return {
	"uloco/bluloco.nvim",
	lazy = false,
	priority = 1000,
	dependencies = { "rktjmp/lush.nvim" },
	config = function()
		require("bluloco").setup({
			style = "auto", -- "auto" | "dark" | "light"
			transparent = false,
			italics = false,
			terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
			guicursor = true,
			rainbow_headings = true, -- if you want different colored headings for each heading level
		})

		vim.opt.termguicolors = true
		vim.cmd("colorscheme bluloco")
	end,
}
