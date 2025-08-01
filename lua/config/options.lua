local icons = require("config.icon")

vim.g.update_in_insert = true
vim.g.border = icons.round
vim.g.blend = 20
vim.g.snacks_animate = false

vim.o.updatetime = 200

vim.diagnostic.config({
  update_in_insert = vim.g.update_in_insert,
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
