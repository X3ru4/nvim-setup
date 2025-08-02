-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local flag = vim.fn.stdpath("data") .. "/restore.flag"
if vim.fn.filereadable(flag) == 1 then
  vim.notify("Load session")
  require("persistence").load({ last = true })
  vim.notify("Done!")
  os.remove(flag)
end

-- Highlight
local get_hl = vim.api.nvim_get_hl
local set_hl = vim.api.nvim_set_hl

local LabelMatch = get_hl(0, { name = "BlinkCmpLabelMatch" })
local Label = get_hl(0, { name = "BlinkCmpLabel" })
local Kind = get_hl(0, { name = "BlinkCmpKind" })

set_hl(0, "Visual", {
  bg = "#104289",
})

set_hl(0, "BlinkCmpMenuSelection", {
  bg = "#313a50",
})
set_hl(0, "BlinkCmpLabelMatch", {
  fg = LabelMatch.fg,
  bg = nil,
})
set_hl(0, "BlinkCmpLabel", {
  fg = Label.fg,
  bg = nil,
})
set_hl(0, "BlinkCmpKind", {
  fg = Kind.fg,
  bg = nil,
})
set_hl(0, "myFloatBorder", {
  fg = get_hl(0, { name = "FloatBorder" }).fg,
  bg = nil,
})
-- End --
