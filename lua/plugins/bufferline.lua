local icons = require("config.icon")
return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      buffer_close_icon = icons.icons.close .. " ",
      modified_icon = icons.icons.modified .. " ",
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
        fg = vim.api.nvim_get_hl(0, { name = "ErrorMsg", link = false }).fg,
      },
      close_button = {
        fg = vim.api.nvim_get_hl(0, { name = "ErrorMsg", link = false }).fg,
      },
      close_button_visible = {
        fg = vim.api.nvim_get_hl(0, { name = "ErrorMsg", link = false }).fg,
      },
      close_button_selected = {
        fg = vim.api.nvim_get_hl(0, { name = "ErrorMsg", link = false }).fg,
        bold = true,
      },
    },
  },
}
