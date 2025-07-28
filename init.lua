-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Highlight
local get_hl = vim.api.nvim_get_hl
local set_hl = vim.api.nvim_set_hl

set_hl(0, "BlinkCmpMenuSelection", {
  bg = get_hl(0, { name = "PmenuSel" }).bg,
  italic = true,
})
local LabelMatch = get_hl(0, { name = "BlinkCmpLabelMatch" })
set_hl(0, "BlinkCmpLabelMatch", {
  bold = true,
  fg = LabelMatch.fg,
})
local Label = get_hl(0, { name = "BlinkCmpLabel" })
set_hl(0, "BlinkCmpLabel", {
  fg = Label.fg,
})
local Kind = get_hl(0, { name = "BlinkCmpKind" })
set_hl(0, "BlinkCmpKind", {
  fg = Kind.fg,
})
-- End --
