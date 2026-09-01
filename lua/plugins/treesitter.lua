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
				disable = { "c", "cpp" },
			},
			matchup = {
				enable = true,
				disable = { "markdown" }, -- evita o crash do treesitter-matchup em md
			},
		}
	end
}
