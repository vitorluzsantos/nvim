return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
	  [[                                                                     ]],
    [[       ███████████           █████      ██                     ]],
    [[      ███████████             █████                             ]],
    [[      ████████████████ ███████████ ███   ███████     ]],
    [[     ████████████████ ████████████ █████ ██████████████   ]],
    [[    █████████████████████████████ █████ █████ ████ █████   ]],
    [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
    [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
    [[ ██████   ██  ███████████████   ██ █████████████████ ]],
    [[ ██████   ██  ███████████████   ██ █████████████████ ]],
		}

    dashboard.section.buttons.val = {
      dashboard.button("e", "  Novo arquivo", "<cmd>ene<CR>"),
      dashboard.button("f", "  Buscar arquivo", "<cmd>Telescope find_files<CR>"),
      dashboard.button("r", "  Recentes", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "  Buscar texto", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("c", "  Config", "<cmd>e $MYVIMRC<CR>"),
      dashboard.button("l", "  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("q", "  Sair", "<cmd>qa<CR>"),
    }

    local function footer()
      local stats = require("lazy").stats()
      local plugins = "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins"
      local date = os.date("%d/%m/%Y %H:%M")
      return { plugins .. "  •  " .. date }
    end
    dashboard.section.footer.val = footer()

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"

    dashboard.opts.layout[1].val = 2
    dashboard.config.opts.noautocmd = true

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        dashboard.section.footer.val = footer()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    alpha.setup(dashboard.opts)
  end,
}
