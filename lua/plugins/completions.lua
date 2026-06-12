return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local loader = require("luasnip.loaders.from_vscode")
      loader.lazy_load()
      loader.lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" }
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      -- 1. Ícones do Menu de Autocompletar
      lspkind.init({
        symbol_map = {
          Text = "  ", Method = "  ", Function = "  ", Constructor = "",
          Field = "  ", Variable = "  ", Class = "  ", Interface = "",
          Module = "", Property = "  ", Unit = "  ", Value = "  ",
          Enum = "", Keyword = "  ", Snippet = "", Color = "  ",
          File = "  ", Reference = "  ", Folder = "  ", EnumMember = "",
          Constant = "  ", Struct = "  ", Event = "", Operator = "  ",
          TypeParameter = "  ",
        },
      })

      -- 2. Ícones de Erro/Aviso e Diagnósticos
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.HINT]  = "  ",
            [vim.diagnostic.severity.INFO]  = "",
          },
        },
        virtual_text = { prefix = '●' },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- [BORDAS] Definimos uma variável para facilitar a manutenção
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- [BORDAS] Aplicando a configuração de borda aqui:
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', 
            maxwidth = 50,
            ellipsis_char = '...',
            before = function (entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip  = "[Snip]",
                buffer   = "[Buf]",
              })[entry.source.name]
              return vim_item
            end
          })
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      -- [BORDAS] Garante que a cor da borda seja vinculada ao estilo do Telescope
      vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
    end,
  },
}

