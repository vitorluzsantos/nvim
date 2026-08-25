return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup {
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "c", "cpp" }, -- usa o cindent nativo pra C/C++
			},
			matchup = {
				enable = true, -- ativa o módulo de matching
			},
		}
	end
}
