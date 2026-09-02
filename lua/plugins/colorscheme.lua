return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
      terminal_colors = false,
    })
    local gruvbox_ansi = {
      "#282828", "#cc241d", "#98971a", "#d79921",
      "#458588", "#b16286", "#689d6a", "#a89984",
      "#928374", "#fb4934", "#b8bb26", "#fabd2f",
      "#83a598", "#d3869b", "#8ec07c", "#ebdbb2",
    }
    for i, color in ipairs(gruvbox_ansi) do
      vim.g["terminal_color_" .. (i - 1)] = color
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "cyberdream",
      callback = function()
        local border_fg = vim.api.nvim_get_hl(0, { name = "Comment", link = false }).fg

        local groups = {
          "Normal",
          "NormalNC",
          "NormalFloat",
          "FloatBorder",
          "SignColumn",
          "EndOfBuffer",
          "LineNr",
          "CursorLineNr",
          "FoldColumn",
          "MsgArea",
          "Pmenu",
          "PmenuSbar",
          "PmenuThumb",
          "WinSeparator",
          "TelescopeNormal",
          "TelescopeBorder",
          "NoiceCmdlinePopup",
          "NoiceCmdlinePopupBorder",
        }
        for _, group in ipairs(groups) do
          local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
          hl.bg = "none"
          vim.api.nvim_set_hl(0, group, hl)
        end

        vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_fg, bg = "none" })
        vim.api.nvim_set_hl(0, "LazyGitFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = border_fg, bg = "none" })
      end,
    })

    vim.cmd("colorscheme cyberdream")
  end,
}
