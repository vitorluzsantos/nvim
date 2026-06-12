return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.keymap.set("n", "<Leader>gg", "<cmd>LazyGit<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<Leader>gc", "<cmd>LazyGitConfig<CR>", { noremap = true, silent = true })
		end,
	},
}
