local icons = require("config.icon")

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "auto",
      component_separators = {
        left = "\\",
        right = "/",
      },
      section_separators = {
        left = "",
        right = "",
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = "" },
        },
      },
      lualine_b = {
        {
          "filetype",
          icon_only = true,
        },
        {
          "filename",
          symbols = {
            modified = icons.icons.modified,
            readonly = "",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostic_icons.errr .. " ",
            warn = icons.diagnostic_icons.warn .. " ",
            info = icons.diagnostic_icons.info .. " ",
            hint = icons.diagnostic_icons.hint .. " ",
          },
        },
        { "searchcount" },
        { "selectioncount" },
        {
          function()
            return " "
          end,
        },
      },
      lualine_z = {
        {
          function()
            return "󰥔 " .. os.date("%R")
          end,
          separator = { right = "" },
        },
      },
    },
  },
}
