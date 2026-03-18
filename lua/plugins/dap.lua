return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"julianolf/nvim-dap-lldb",
		},
		config = function()
			local dap = require("dap")
			local widgets = require("dap.ui.widgets")
			local ui = require("dapui")
			local lldb = require("dap-lldb")

			lldb.setup({
				configurations = {
					c = {
						{
							name = "Launch debugger",
							type = "lldb",
							request = "launch",
							cwd = "${workspaceFolder}",
							program = function()
								-- Build with debug symbols
								local out = vim.fn.system({ "make", "debug" })
								-- Check for errors
								if vim.v.shell_error ~= 0 then
									vim.notify(out, vim.log.levels.ERROR)
									return nil
								end
								-- Return path to the debuggable program
								return "main"
							end,
						},
					},
				},
			})

			ui.setup()

			local km = vim.keymap
			km.set("n", "<Leader>do", dap.step_over, { desc = "Debug Step Over" })
			km.set("n", "<Leader>di", dap.step_into, { desc = "Debug Step Into" })
			km.set("n", "<Leader>du", dap.step_out, { desc = "Debug Step Out" })
			km.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Debug Toggle Breakpoint" })
			km.set("n", "<Leader>dc", dap.continue, { desc = "Debug Toggle Continue" })
			km.set("n", "<Leader>dr", dap.repl.open, { desc = "Debug Replay Open" })
			km.set("n", "<Leader>dl", dap.run_last, { desc = "Debug Run Last" })
			km.set({ "n", "v" }, "<Leader>dh", widgets.hover, { desc = "Debug Hover" })
			km.set({ "n", "v" }, "<Leader>dp", widgets.preview, { desc = "Debug Preview" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
