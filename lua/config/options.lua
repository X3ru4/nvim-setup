local diagnostic = require("config.icons").diagnostic

vim.g.update_in_insert = false
vim.g.border = nil
vim.g.blend = 0
vim.g.snacks_animate = false

vim.o.updatetime = 200

vim.diagnostic.config({
  update_in_insert = vim.g.update_in_insert,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic.errr,
      [vim.diagnostic.severity.WARN] = diagnostic.warn,
      [vim.diagnostic.severity.INFO] = diagnostic.info,
      [vim.diagnostic.severity.HINT] = diagnostic.hint,
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
