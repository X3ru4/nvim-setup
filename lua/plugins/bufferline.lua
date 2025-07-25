local icons = require("config.icon")

return {
  -- enabled = false,
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      buffer_close_icon = icons.icons.close .. " ",
      modified_icon = icons.icons.modified .. " ",
      close_icon = " ",
      left_trunc_marker = " ",
      right_trunc_marker = " ",
      diagnostics = "nvim_lsp",
      hover = { enabled = false },
    },
  },
}
