-- return {
--   "nvimdev/indentmini.nvim",
--   config = function ()
--     require("indentmini").setup()
--     vim.cmd.highlight('IndentLine guifg=#34424a')
--     vim.cmd.highlight('IndentLineCurrent guifg=#e06c75')
--   end
-- }

return {
  "shellRaining/hlchunk.nvim",
  event = "BufReadPre",
  config = function()
    require('hlchunk').setup({
      chunk = {
        enable = true,
        priority = 15,
        style = {
          { fg = "#806d9c" },
          { fg = "#c21f30" },
        },
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "→",
        },
        error_sign = true,
        -- animation related
        duration = 200,
        delay = 155,
      },
      indent = {
        enable = true,
        chars = {
          "│",
          "¦",
          "┆",
          "┊",
        },
      }
    })
  end
}
