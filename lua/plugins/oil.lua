return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "stevearc/dressing.nvim" },
		config = function()
			require("oil").setup({
				-- 1. COMPATIBILIDADE: Mantém a Neo-tree na lateral
				default_file_explorer = false,
				delete_to_trash = true,
				skip_confirm_for_simple_edits = false,

				-- 2. JANELA DE CONFIRMAÇÃO (Save/Delete)
				confirmation = {
					border = "rounded",
					window_conf = {
						winhighlight = "Normal:TelescopePromptNormal,NormalFloat:TelescopePromptNormal,FloatBorder:TelescopeBorder",
					},
				},

				-- 3. JANELA DE PROGRESSO (Loading)
				progress = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = { 10, 0.9 },
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					minimized_border = "none",
					win_options = {
						winhighlight = "Normal:TelescopePromptNormal,NormalFloat:TelescopePromptNormal,FloatBorder:TelescopeBorder",
						winblend = 0,
					},},

				-- 4. VISUAL DA LISTA DE ARQUIVOS
				view_options = {
					show_hidden = true,
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, "..")
					end,
				},

				-- 5. ATALHOS INTERNOS
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-p>"] = "actions.preview",
					["q"] = "actions.close",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
				},
			}) -- <--- AQUI É ONDE O SETUP REALMENTE FECHA

			-- Atalhos de teclado
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir Oil" })
			vim.keymap.set("n", "<leader>-", function() require("oil").toggle_float() end, { desc = "Oil Flutuante" })
		end,
	},
}

