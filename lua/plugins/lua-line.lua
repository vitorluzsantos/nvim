return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- colorscheme
    vim.cmd("colorscheme carbonfox")

    local palette = require("nightfox.palette").load("carbonfox")

    local my_bg = "#161616"
    local fg = palette.fg1

    -- modo reduzido (N, I, V...)
    local function mode_letter(str)
      local map = {
        NORMAL = "N",
        INSERT = "I",
        VISUAL = "V",
        REPLACE = "R",
        COMMAND = "C",
        TERMINAL = "T",
      }
      return map[str] or str:sub(1, 1)
    end

    -- tema consistente com tabby
    local theme = {
      normal = {
        a = { fg = my_bg, bg = palette.cyan.base, gui = "bold" },
        b = { fg = fg, bg = my_bg },
        c = { fg = fg, bg = my_bg },
      },
      insert = {
        a = { fg = my_bg, bg = palette.green.base, gui = "bold" },
      },
      visual = {
        a = { fg = my_bg, bg = palette.magenta.base, gui = "bold" },
      },
      replace = {
        a = { fg = my_bg, bg = palette.red.base, gui = "bold" },
      },
      command = {
        a = { fg = my_bg, bg = palette.orange.base, gui = "bold" },
      },
      inactive = {
        a = { fg = fg, bg = my_bg },
        b = { fg = fg, bg = my_bg },
        c = { fg = fg, bg = my_bg },
      },
    }

    require("lualine").setup({
      options = {
        theme = theme,
        section_separators = "",     -- sem powerline (combina com tabby clean)
        component_separators = "|",  -- simples e estável
        globalstatus = true,
        icons_enabled = true,
      },

      sections = {
        lualine_a = {
          { "mode", fmt = mode_letter },
        },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
    })

    -- força fundo igual ao tabby
    vim.api.nvim_set_hl(0, "StatusLine", { bg = my_bg })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = my_bg })
  end,
}
