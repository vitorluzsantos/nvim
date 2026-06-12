return {
	"nanozuki/tabby.nvim",
	dependencies = {
		"EdenEast/nightfox.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.cmd("colorscheme carbonfox")

		local palette  = require("nightfox.palette").load("carbonfox")
		local devicons = require("nvim-web-devicons")

		local my_bg       = "#161616"
		local active_bg   = "#2d1f2d"
		local active_fg   = palette.pink.base
		local inactive_fg = palette.fg3
		local number_fg   = palette.pink.dim  -- número da tab em rosa apagado

		local sl_right = ""   -- U+E0BC slant fino
		local sl_left  = ""   -- U+E0BE slant fino

		local theme = {
			fill         = { bg = my_bg },
			current_tab  = { fg = active_fg,        bg = active_bg, bold = true },
			tab          = { fg = inactive_fg,      bg = my_bg },
			num_active   = { fg = number_fg,        bg = active_bg, bold = true },
			num_inactive = { fg = palette.bg4,      bg = my_bg },
			sep_active_l = { fg = active_bg,        bg = my_bg },
			sep_active_r = { fg = active_bg,        bg = my_bg },
			-- separador inativo: rosa dim no fundo escuro — aparece bonito em diagonal
			sep_inactive = { fg = palette.pink.dim, bg = my_bg },
			modified     = { fg = palette.yellow.base, bg = active_bg },
			modified_nc  = { fg = palette.yellow.dim,  bg = my_bg },
		}
		local function get_tab_info(tabid)
			local ok, winid = pcall(vim.api.nvim_tabpage_get_win, tabid)
			if not ok then return "", "", false end
			local bufnr   = vim.api.nvim_win_get_buf(winid)
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local modified = vim.bo[bufnr].modified
			if bufname == "" then return "[No Name]", "", modified end
			local fname = vim.fn.fnamemodify(bufname, ":t")
			local ext   = vim.fn.fnamemodify(bufname, ":e")
			local icon, _ = devicons.get_icon(fname, ext, { default = true })
			return fname, icon or "", modified
		end

		require("tabby").setup({
			option = { theme = theme },
			line = function(line)
				return {
					{ "  ", hl = theme.fill },

					line.tabs().foreach(function(tab)
						local is_cur  = tab.is_current()
						local num     = tab.number()
						local tabid   = tab.id
						local name, icon, modified = get_tab_info(tabid)
						local mod_sym = modified and " ●" or ""

						if is_cur then
							return {
								{ sl_left,                       hl = theme.sep_active_l },
								{ " " .. num,                    hl = theme.num_active   },
								{ " " .. icon .. " ",            hl = theme.current_tab  },
								{ name .. mod_sym .. " ",        hl = theme.current_tab  },
								{ sl_right,                      hl = theme.sep_active_r },
								{ " ",                           hl = theme.fill         },
							}
						else
							return {
								{ " " .. num,                    hl = theme.num_inactive },
								{ " " .. icon .. " ",            hl = theme.tab          },
								{ name .. mod_sym .. " ",        hl = modified and theme.modified_nc or theme.tab },
								{ sl_right,                      hl = theme.sep_inactive },
								{ " ",                           hl = theme.fill         },
							}
						end
					end),

					line.spacer(),
					{ "  ", hl = theme.fill },
				}
			end,
		})

		vim.api.nvim_set_hl(0, "TabLineFill", { bg = my_bg })
		vim.api.nvim_set_hl(0, "TabLine",     { bg = my_bg })
		vim.api.nvim_set_hl(0, "TabLineSel",  { bg = active_bg })
		vim.o.showtabline = 1

		-- Atalho: <leader>t abre nova tab com o diretório atual
		-- <leader>t: abre telescope e o arquivo escolhido vai para nova tab
		vim.keymap.set("n", "<leader>t", function()
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			require("telescope.builtin").find_files({
				prompt_title = "  Nova Tab",
				attach_mappings = function(prompt_bufnr, map)
					-- sobrescreve o <CR> para abrir em nova tab
					actions.select_default:replace(function()
						actions.close(prompt_bufnr)
						local selection = action_state.get_selected_entry()
						if selection then
							vim.cmd("tabnew " .. vim.fn.fnameescape(selection[1]))
						end
					end)
					return true
				end,
			})
		end, { desc = "Nova tab com arquivo" })

		-- Bônus: navegar entre tabs com ] e [ 
		vim.keymap.set("n", "<leader>]", "<cmd>tabnext<CR>",     { desc = "Próxima tab" })
		vim.keymap.set("n", "<leader>[", "<cmd>tabprevious<CR>", { desc = "Tab anterior" })
		-- <leader>w: fecha a tab atual (só se não tiver modificações não salvas)
		vim.keymap.set("n", "<leader>w", function()
			local modified = vim.bo.modified
			if modified then
				vim.notify("Salve o arquivo antes de fechar a tab  (:w)", vim.log.levels.WARN)
			else
				vim.cmd("tabclose")
			end
		end, { desc = "Fechar tab atual" })
	end,
}
