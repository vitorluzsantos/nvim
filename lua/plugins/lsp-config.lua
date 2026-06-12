return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local border = "rounded"

			-- [CORREÇÃO] Ícones compactos para evitar erro E239
			local signs = { Error = "✘", Warn = "▲", Hint = "  ", Info = "»" }
			for type, icon in pairs(signs) do
				local name = "DiagnosticSign" .. type
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end

			-- Configurações de Bordas
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
			require('lspconfig.ui.windows').default_options.border = border
			vim.diagnostic.config({ float = { border = border } })

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd", "html", "cssls" },

				handlers = {
					-- Handler padrão (Configura automaticamente o que não for definido abaixo)
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- Configuração específica para LUA
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = { globals = { "vim" } },
									workspace = { checkThirdParty = false },
								},
							},
						})
					end,

					-- Configuração específica para C/C++
					["clangd"] = function()
						lspconfig.clangd.setup({
							capabilities = capabilities,
							cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
						})
					end,

					-- Configuração específica para HTML
					["html"] = function()
						lspconfig.html.setup({
							capabilities = capabilities,
							init_options = {
								configurationSection = { "html", "css", "javascript" },
								embeddedLanguages = { css = true, javascript = true },
								provideFormatter = true,
							},
						})
					end,
				},
			})

			-- Atalhos de teclado
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
		end,
	},
}

