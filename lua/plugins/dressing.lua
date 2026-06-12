return {
  {
    "stevearc/dressing.nvim",
    -- IMPORTANTE: Definir como false garante que ele intercepte o primeiro input do Oil
    lazy = false, 
    opts = {
      input = {
        -- Habilita a interface customizada
        enabled = true,
        default_prompt = "➤ ",
        title_pos = "center",
        insert_only = true,
        start_in_insert = true,
        border = "rounded", -- Bordas arredondadas (como o seu Oil e Telescope)
        relative = "editor",
        prefer_width = 50,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        win_options = {
          -- [O SEGREDO] Forçamos o fundo (Normal e NormalFloat) a usar a cor do Telescope
          -- Isso resolve o problema de o fundo ficar preto/diferente do tema Carbonfox
          winhighlight = "Normal:TelescopeNormal,NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder",
          winblend = 0,
        },
        -- Teclas para fechar ou confirmar a janelinha
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
        },
      },
      select = {
        -- Melhora a tela de escolha (ex: Code Actions do LSP)
        enabled = true,
        backend = { "telescope", "builtin" },
        -- Faz a lista de seleção abrir como um dropdown do Telescope
        telescope = require("telescope.themes").get_dropdown({
          layout_config = {
            width = 0.5,
            height = 0.4,
          },
        }),
      },
    },
  },
}

