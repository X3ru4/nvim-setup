local get_hl = vim.api.nvim_get_hl
local set_hl = vim.api.nvim_set_hl
set_hl(0, "myCursorline", {
  bg = get_hl(0, { name = "CursorLine", link = false }).bg,
  bold = true,
  italic = true,
})
set_hl(0, "myFloatBorder", { get_hl(0, { name = "FloatBorder", link = false }) })
set_hl(0, "CmpItemAbbrMatch", {
  fg = get_hl(0, { name = "identifier", link = false }).fg,
  bold = true,
})
set_hl(0, "CmpItemAbbrMatchFuzzy", {
  fg = get_hl(0, { name = "LspDiagnosticsHint", link = false }).fg,
  bold = true,
})
