-- Configurações de tabulação
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.keymap.set('n','[d', vim.diagnostic.goto_prev);
vim.keymap.set('n','d]', vim.diagnostic.goto_next);


-- Undotree diff command (Windows)
vim.g.undotree_DiffCommand = "C:/Program Files/Git/usr/bin/diff.exe"

-- Scroll
vim.o.scrolloff = 8

-- Número de linhas
vim.opt.number = true

-- Atalhos de inserção de linha
vim.keymap.set("n", "<space>o", "o<Esc>", {})
vim.keymap.set("n", "<space>O", "O<Esc>", {})

-- Força o buffer dbout a abrir com altura decente
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  callback = function()
    if vim.bo.filetype == "dbout" then
      vim.schedule(function()
        vim.cmd("wincmd _")   -- maximiza altura do split
        vim.cmd("resize 20")  -- altura mínima decente
      end)
    end
  end,
})

-- Trava a altura do dbout para que outros plugins não mexam
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dbout",
  callback = function()
    vim.opt_local.winfixheight = true
  end,
})
-- Mapeia <leader>db para abrir o Dadbod UI
vim.keymap.set('n', '<space>db', ':DBUIToggle<CR>', { noremap = true, silent = true, desc = 'Toggle Dadbod UI' })
vim.keymap.set('n', '<space>da', ':DBUIAddConnection<CR>', { noremap = true, silent = true, desc = 'Toggle Dadbod UI' })

-- Atalho para limpar o arquivo Shada e resetar o histórico
vim.keymap.set("n", "<space>cs", function()
    local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")

    -- Limpa o shada da sessão atual primeiro
    vim.cmd("set shada=")

    -- Executa o comando de deleção (Windows)
    local success = os.execute('del /q "' .. shada_path .. '\\*"')

    if success then
        print("Arquivo Shada limpo com sucesso!")
    else
        print("Erro ao limpar Shada (verifique se há instâncias abertas).")
    end
end, { desc = "Clear Shada (Histórico)" })

