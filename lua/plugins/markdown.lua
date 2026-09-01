return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- ícones, opcional mas fica melhor
    },
    opts = {
      heading = {
        enabled = true,
        sign = false,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      },
      code = {
        enabled = true,
        style = "normal", -- evita bugs de largura de bloco em alguns temas
      },
      bullet = {
        enabled = true,
      },
      checkbox = {
        enabled = true,
      },
    },
  },
}
