return {
  "nvimdev/lspsaga.nvim",
  opts = {
    ui = {
      border = "rounded",
      devicon = true,
      code_action = " ",
      actionfix = " ",
    },
    symbol_in_winbar = { enable = false },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
