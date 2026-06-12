return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim", -- Para gerenciar DAPs com Mason
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Configuração do dap-ui
		dapui.setup()

		-- Abrir UI automaticamente na depuração
		dap.listeners.after.event_initialized.dapui_config = function()
			dapui.open()
		end
		dap.listeners.after.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.after.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Configuração do DAP para C++
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
		}

		dap.configurations.cpp = {
			{
				name = "Executar C++",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Caminho do executável: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "Enable GDB pretty printing",
						ignoreFailures = false,
					},
				},
			},
		}

		-- Atalhos
		vim.keymap.set("n", "<space>dt", dap.toggle_breakpoint, { noremap = true, silent = true })
		vim.keymap.set("n", "<space>dc", function()
			dap.toggle_breakpoint()
			dapui.open()
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<C-S-p>", dap.continue, { noremap = true, silent = true })
		vim.keymap.set("n", "<space>q", dapui.close, { noremap = true, silent = true })
		vim.keymap.set("n", "<space>b", dap.continue, { noremap = true, silent = true })
		vim.keymap.set("n", "<space>n", dap.step_over, { noremap = true, silent = true })
	end,
}
