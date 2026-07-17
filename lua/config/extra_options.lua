local M = {}
local Colorscheme = require("utility.colorscheme")

Colorscheme.default = "onedark"

M.blinkcmp = {
  menu = {
    border = nil
  },
  documentation = {
    auto_show = false,
    border = nil
  },
  appearance = {
    use_nvimcmp_hl = false
  }
}

M.statusline = {
  separator = { "", "" }
}

return M
