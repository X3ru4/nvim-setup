return {
  "nvimdev/indentmini.nvim",
  config = function ()
    require("indentmini").setup()
    vim.cmd.highlight('IndentLine guifg=#34424a')
    vim.cmd.highlight('IndentLineCurrent guifg=#e06c75')
  end
}
