return {
  "shellRaining/hlchunk.nvim",
  event = "BufReadPre",
  config = function()
    require('hlchunk').setup({
      chunk = {
        enable = true,
        priority = 15,
        style = {
          { fg = vim.g.color_palette.dark_purple },
          { fg =  vim.g.color_palette.dark_red },
        },
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        error_sign = true,
        -- animation related
        duration = 0,
        delay = 0,
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
