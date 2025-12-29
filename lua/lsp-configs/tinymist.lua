return {
	settings = {
		-- Compilation and status
		compileStatus = "enable",
		semanticTokens = "disable",
		systemFonts = true,

		-- Export settings
		exportPdf = "onType", -- Options: "never", "onSave", "onType"
		exportTarget = "paged", -- Options: "paged", "html"

		-- Formatter settings
		formatterMode = "typstyle", -- Options: "disable", "typstyle", "typstfmt"
		formatterIndentSize = 2,
		formatterPrintWidth = 120,
		formatterProseWrap = false,

		-- Completion settings
		completion = {
			postfix = true,
			postfixUfcs = true,
			postfixUfcsLeft = true,
			postfixUfcsRight = true,
			symbol = "step", -- Options: "step", "stepless"
			triggerOnSnippetPlaceholders = false,
		},

		-- Linting
		lint = {
			enabled = false,
			when = "onSave", -- Options: "onSave", "onType"
		},

		-- Preview settings
		preview = {
			partialRendering = true,
			refresh = "onType", -- Options: "onSave", "onType"
			invertColors = "never", -- Options: "never", "auto", "always"
		},

		-- Project settings
		projectResolution = "lockDatabase", -- Options: "singleFile", "lockDatabase"
		outputPath = "",

		-- Additional typst CLI arguments (if needed)
		typstExtraArgs = {},
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
}
