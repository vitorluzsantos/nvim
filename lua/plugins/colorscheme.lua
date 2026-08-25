return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      -- Ativa o tema transparente nativo do plugin
      transparent = true,

      -- Deixa comentários em itálico
      italic_comments = true,

      -- Esconde fillchars como EndOfBuffer (~)
      hide_fillchars = true,

      -- Remove borda do Telescope (fica mais clean com transparência)
      borderless_telescope = true,

      -- Aplica a paleta também nas cores do terminal integrado
      terminal_colors = true,

      -- Estilo do tema: "default" ou "dark" (cyberdream tem variante padrão só)
      -- theme = { variant = "default" },
    })

    vim.cmd("colorscheme cyberdream")

    -- Reforço manual: garante fundo transparente em grupos que
    -- às vezes escapam do transparent=true do plugin
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "cyberdream",
      callback = function()
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
          vim.api.nvim_set_hl(0, group, { bg = "none" })
        end
      end,
    })
  end,
}
