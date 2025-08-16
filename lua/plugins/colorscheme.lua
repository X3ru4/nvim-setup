return {
  "navarasu/onedark.nvim",
  event = "VimEnter",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "darker",
      ending_tildes = true,
      code_style = {
        comments = "none",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },
    })
    vim.cmd("colorscheme onedark")
  end,
}
