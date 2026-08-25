-- lua/plugins/lualine.lua
-- Lualine transparente, adaptado às cores do colorscheme ativo (modus-vivendi, carbonfox, etc)

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Pega as cores diretamente do colorscheme ativo, então funciona
    -- tanto no modus-vivendi quanto se você voltar pro carbonfox/nightfox
    local function get_hl(name, attr)
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      return hl[attr] and string.format("#%06x", hl[attr]) or nil
    end

    local colors = {
      bg      = "NONE", -- transparente
      fg      = get_hl("Normal", "fg") or "#ffffff",
      accent  = get_hl("Function", "fg") or get_hl("Statement", "fg") or "#61afef",
      red     = get_hl("DiagnosticError", "fg") or "#e06c75",
      yellow  = get_hl("DiagnosticWarn", "fg") or "#e5c07b",
      green   = get_hl("DiagnosticOk", "fg") or get_hl("String", "fg") or "#98c379",
      blue    = get_hl("DiagnosticInfo", "fg") or "#61afef",
      gray    = get_hl("Comment", "fg") or "#5c6370",
      violet  = get_hl("Constant", "fg") or "#c678dd",
    }

    local transparent_theme = {
      normal = {
        a = { bg = colors.bg, fg = colors.accent, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.gray },
      },
      insert   = { a = { bg = colors.bg, fg = colors.green, gui = "bold" } },
      visual   = { a = { bg = colors.bg, fg = colors.violet, gui = "bold" } },
      replace  = { a = { bg = colors.bg, fg = colors.red, gui = "bold" } },
      command  = { a = { bg = colors.bg, fg = colors.yellow, gui = "bold" } },
      inactive = {
        a = { bg = colors.bg, fg = colors.gray },
        b = { bg = colors.bg, fg = colors.gray },
        c = { bg = colors.bg, fg = colors.gray },
      },
    }

    require("lualine").setup({
      options = {
        theme = transparent_theme,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        icons_enabled = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          { "filename", path = 1 },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "fzf", "trouble" },
    })

    -- Recalcula as cores toda vez que o colorscheme mudar
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.schedule(function()
          require("lualine").refresh()
        end)
      end,
    })
  end,
}
