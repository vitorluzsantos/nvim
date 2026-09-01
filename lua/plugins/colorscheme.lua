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
      -- DESLIGADO: se true, a cyberdream sobrescreve a paleta ANSI
      -- (terminal_color_0..15) com as próprias cores dela. Isso é
      -- o que fazia o lazygit (que roda dentro de um terminal e
      -- usa essa paleta de 16 cores pra se desenhar) ficar com
      -- cores diferentes do lazygit rodando no Kitty puro, que usa
      -- o tema gruvbox do próprio terminal.
      terminal_colors = false,
      -- Estilo do tema: "default" ou "dark" (cyberdream tem variante padrão só)
      -- theme = { variant = "default" },
    })

    -- Paleta ANSI do gruvbox dark, igual ao tema do seu Kitty.
    -- Setando isso manualmente, o :terminal do Neovim (e portanto
    -- o lazygit.nvim, que abre o lazygit dentro dele) usa as
    -- mesmas 16 cores que o terminal de verdade.
    local gruvbox_ansi = {
      "#282828", "#cc241d", "#98971a", "#d79921",
      "#458588", "#b16286", "#689d6a", "#a89984",
      "#928374", "#fb4934", "#b8bb26", "#fabd2f",
      "#83a598", "#d3869b", "#8ec07c", "#ebdbb2",
    }
    for i, color in ipairs(gruvbox_ansi) do
      vim.g["terminal_color_" .. (i - 1)] = color
    end

    -- Reforço manual: garante fundo transparente em grupos que
    -- às vezes escapam do transparent=true do plugin.
    --
    -- IMPORTANTE #1: o autocmd precisa ser registrado ANTES de
    -- `vim.cmd("colorscheme cyberdream")`, senão o evento
    -- ColorScheme já disparou antes do autocmd existir.
    --
    -- IMPORTANTE #2: o lazygit.nvim usa highlight groups próprios
    -- (LazyGitFloat/LazyGitBorder), não FloatBorder/NormalFloat.
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
