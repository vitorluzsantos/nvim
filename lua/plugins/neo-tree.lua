return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "muniftanjim/nui.nvim",
  },
  opts = {
    window = {
      width = 30,
      position = "right",
      mappings = {
        ["<space>"] = "none",
        ["P"] = { "toggle_preview", config = { use_float = true } }, -- Atalho para o preview
      },
    },
    popup_border_style = "rounded", -- Borda arredondada igual ao Telescope
    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "  ",
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right toggle<CR>", { desc = "Toggle Neo-tree" })

    local function fix_neotree_colors()
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })

      -- Cores do Preview para combinar com o Telescope no Carbonfox
      vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { link = "Normal" })
      vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = "#393939", bg = "none" }) -- Cor da borda do Telescope
      vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = "#78a9ff", bold = true })   -- Azul Carbonfox

      -- 1. Deixa o símbolo ~ invisível
      vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { fg = "bg", bg = "none" })
    end

    -- 2. Remove o caractere ~ definindo-o como um espaço vazio apenas no Neo-tree
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function()
        vim.opt_local.fillchars:append({ eob = " " })
      end,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = fix_neotree_colors,
    })

    fix_neotree_colors()
  end,
}

