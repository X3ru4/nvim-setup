-- bootstrap lazy.nvim, LazyVim and your plugins

diagnostic_icons= {
  errr =  '',
  warn  = '',
  info  = '󰋼',
  hint  = ''
}

icons = {
  modified = '󱇨',
  close    = '',
  pinned   = ''
}

require("config.lazy")

-- Cmp highlight
local get_hl    = vim.api.nvim_get_hl
local match_hl  = get_hl(0, { name = "Identifier", link = false })
local normal_hl = get_hl(0, { name = "Normal", link = true })
local slhl      = get_hl(0, { name = "CursorLine", link = false })
local fuzzy_hl  = get_hl(0, { name = "LspDiagnosticsHint", link = false })

vim.api.nvim_set_hl(0, "menu", {
  fg = normal_hl.fg,
  bg = normal_hl.bg
})
vim.api.nvim_set_hl(0, "menu_sl", {
  bg   = slhl.bg,
  bold = true,
  italic = true,
})
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {
  fg   = match_hl.fg,
  bold = true
})
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {
  fg   = fuzzy_hl.fg,
  bold = true
})

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
    spacing = 2
  },
  underline = true,
  update_in_insert = true,
  float = {
    header = false,
    border = 'rounded',
    focusable = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_icons.errr,
      [vim.diagnostic.severity.WARN]  = diagnostic_icons.warn,
      [vim.diagnostic.severity.INFO]  = diagnostic_icons.info,
      [vim.diagnostic.severity.HINT]  = diagnostic_icons.hint,
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
}
