return {
	"ishan9299/modus-theme-vim",
	priority = 1000,
	config = function ()
		vim.opt.background = "dark"

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				local groups = {
					"Normal",
					"NormalNC",
					"NonText",
					"LineNr",
					"SignColumn",
					"EndOfBuffer",
					"FoldColumn",
					"Folded",
				}
				for _, group in ipairs(groups) do
					vim.api.nvim_set_hl(0, group, { bg = "none" })
				end
			end,
		})

		vim.cmd.colorscheme("modus-vivendi")
	end
}
