local function open_floating_terminal()
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = vim.api.nvim_create_buf(false, true)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = width,
		height = height,
		col = col,
		row = row,
		style = 'minimal',
		border = 'rounded',
	})

	-- Garante que o buffer seja deletado ao fechar a janela
	vim.bo[buf].bufhidden = "wipe"

	vim.cmd('terminal powershell.exe')
	vim.cmd('startinsert')
end

-- Comandos e Mapeamentos
vim.api.nvim_create_user_command('Floaterm', open_floating_terminal, {})
vim.keymap.set('n', '<space>tt', '<CMD>Floaterm<CR>', { desc = 'Open Floating Terminal' })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Voltar para modo Normal" })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>q]], { desc = "Fechar terminal flutuante" })
vim.keymap.set('n', '<C-h>', '<C-w>q', { desc = "Fechar janela" })

-- Auto-comando para fechar buffer ao sair do terminal
vim.api.nvim_create_autocmd("TermClose", {
	callback = function()
		vim.cmd("bdelete!")
	end
})

