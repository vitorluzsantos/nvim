return {
  "R-nvim/R.nvim",
  lazy = false, -- precisa carregar cedo pra detectar filetypes .R/.Rmd/.qmd
  config = function()
    local opts = {
      R_app = "R", -- sem radian instalado, usa o R normal mesmo
      R_cmd = "R",
      hook = {
        on_filetype = function()
          -- keymaps só dentro de buffers R/Rmd/Quarto
          local map = vim.keymap.set
          map("n", "<Enter>", "<Plug>RDSendLine", { buffer = true, silent = true })
          map("v", "<Enter>", "<Plug>RSendSelection", { buffer = true, silent = true })
          map("n", "<leader>rf", "<Plug>RSendFile", { buffer = true, silent = true })
          map("n", "<leader>rs", "<Plug>RStart", { buffer = true, silent = true })
          map("n", "<leader>rq", "<Plug>RClose", { buffer = true, silent = true })
          map("n", "<leader>ro", "<Plug>ROBToggle", { buffer = true, silent = true }) -- object browser
          map("n", "<leader>rd", "<Plug>RViewDF", { buffer = true, silent = true }) -- ver data.frame
          map("n", "<leader>rh", "<Plug>RHelp", { buffer = true, silent = true })
          map("n", "<leader>rm", "<Plug>RClearAll", { buffer = true, silent = true }) -- limpa o ambiente (rm(list=ls()))
        end,
      },
    }
    require("r").setup(opts)
  end,
}
