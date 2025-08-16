local icons = require("config.icons").icons
local errorfg = vim.api.nvim_get_hl(0, { name = "ErrorMsg", link = false }).fg

return {
  "akinsho/bufferline.nvim",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  opts = {
    options = {
      buffer_close_icon = icons.close .. " ",
      modified_icon = icons.modified .. " ",
      left_trunc_marker = " ",
      right_trunc_marker = " ",
      diagnostics = "nvim_lsp",
      hover = { enabled = false },
      -- show_buffer_close_icons = false,
      indicator = { style = "none" },
      separator_style = "thin",
    },
    highlights = {
      tab_close = {
        fg = errorfg,
      },
      close_button = {
        fg = errorfg,
      },
      close_button_visible = {
        fg = errorfg,
      },
      close_button_selected = {
        fg = errorfg,
        bold = true,
      },
    },
  },
}
