return {
  -- Core
  {
    "tpope/vim-dadbod",
    init = function()
      -- Conexão padrão global usando login-path
      vim.g.db = "mysql:///?login-path=local"
    end,
  },

  -- UI
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },

    init = function()
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui_queries"
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_winwidth = 40
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_max_query_results = 2000
      vim.g.db_ui_max_column_width = 100

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dbout",
        callback = function()
          vim.wo.foldenable = false
        end,
      })
    end,

    config = function()
      -- Abrir/fechar UI
      vim.keymap.set("n", "<leader>du", "<cmd>DBUIToggle<CR>", { desc = "Toggle DBUI", silent = true, noremap = true })

      -- Rodar todo o buffer com USE automático
      vim.keymap.set("n", "<leader>dr", function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local db_name = "default"
        for _, line in ipairs(lines) do
          local name = line:match("^%-%- db:%s*(%S+)")
          if name then
            db_name = name
            break
          end
        end
        if not lines[1]:match("^USE") then
          table.insert(lines, 1, "USE " .. db_name .. ";")
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        end
        vim.cmd("DB")
      end, { desc = "Run query with automatic USE from buffer", silent = true, noremap = true })

      -- Rodar apenas seleção (visual mode)
      vim.keymap.set("v", "<leader>rr", function()
        vim.cmd("DB")
      end, { desc = "Run selected query without modifying buffer", silent = true, noremap = true })

      -- Salvar + executar
      vim.keymap.set("n", "<leader>ds", function()
        vim.cmd("w")
        vim.cmd("DB")
      end, { desc = "Save and run query", silent = true, noremap = true })

      -- Fechar tudo (UI + resultados + queries)
      vim.keymap.set("n", "<leader>dq", function()
        vim.cmd("DBUIClose")
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")
          if ft == "sql" or ft == "dbui" or ft == "dbout" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end, { desc = "Close DBUI + all buffers", silent = true, noremap = true })

      -- Fechar apenas resultados
      vim.keymap.set("n", "<leader>do", function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_get_option(buf, "filetype") == "dbout" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end, { desc = "Close DB output", silent = true, noremap = true })

      -- Mostrar tabelas da conexão ativa
      vim.keymap.set("n", "<leader>dt", function()
        vim.cmd("DB SHOW TABLES;")
      end, { desc = "List tables of active database", silent = true, noremap = true })
    end,
  },

  -- Autocomplete
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" },
  },
}
