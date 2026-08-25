return {
  "mattn/emmet-vim",
  ft = { "html", "css", "javascriptreact", "typescriptreact", "vue", "php" },
  config = function()
    vim.keymap.set(
      { "n", "i" },
      "<leader>e",
      "<Plug>(emmet-expand-abbr)",
      { desc = "Emmet: expandir abreviação", remap = true }
    )
  end,
}
