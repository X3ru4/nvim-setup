-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local icons = require("config.icon")

-- Cmp highlight
vim.api.nvim_set_hl(0, "menu_sl", {
  bold = true,
  italic = true,
})
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {
  bold = true
})
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {
  bold = true
})

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostic_icons.errr,
      [vim.diagnostic.severity.WARN]  = icons.diagnostic_icons.warn,
      [vim.diagnostic.severity.INFO]  = icons.diagnostic_icons.info,
      [vim.diagnostic.severity.HINT]  = icons.diagnostic_icons.hint,
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
}
