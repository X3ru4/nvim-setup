return {
  "folke/tokyonight.nvim",
  name = "tokyonight",
  config = function ()
    require("tokyonight").setup()
    vim.cmd.colorscheme("tokyonight")
  end,
}
