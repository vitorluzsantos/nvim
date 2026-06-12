return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<C-u>", function()
			vim.cmd("UndotreeToggle")
		end)

		vim.g.undotree_WindowLayout = 3
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_SplitWidth = 30 -- Define a largura desejada

		-- Autocomando para forçar a largura e fixar ao abrir
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "undotree",
			callback = function()
				vim.cmd("vertical resize " .. vim.g.undotree_SplitWidth)
				vim.opt_local.winfixwidth = true
			end,
		})
	end,
}

