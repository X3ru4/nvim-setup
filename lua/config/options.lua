local icons = require("config.icon")

_G.update_in_insert = true
_G.border = icons.round
_G.blend = 20

vim.o.updatetime = 200
vim.g.snacks_animate = false

vim.diagnostic.config({
  update_in_insert = _G.update_in_insert,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostic_icons.errr,
      [vim.diagnostic.severity.WARN] = icons.diagnostic_icons.warn,
      [vim.diagnostic.severity.INFO] = icons.diagnostic_icons.info,
      [vim.diagnostic.severity.HINT] = icons.diagnostic_icons.hint,
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
