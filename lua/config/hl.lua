-- Highlight

local get_hl = vim.api.nvim_get_hl

local LabelMatch = get_hl(0, { name = "BlinkCmpLabelMatch" })
local Label = get_hl(0, { name = "BlinkCmpLabel" })
local Kind = get_hl(0, { name = "BlinkCmpKind" })

local Highlight = {
  Visual = {
    bg = "#0f4c81",
  },
  BlinkCmpMenuSelection = {
    bg = vim.api.nvim_get_hl(0, { name = "PmenuSel" }).bg,
  },
  BlinkCmpLabelMatch = {
    fg = LabelMatch.fg,
    bg = nil,
  },
  BlinkCmpLabel = {
    fg = Label.fg,
    bg = nil,
  },
  BlinkCmpKind = {
    fg = Kind.fg,
    bg = nil,
  },
  myFloatBorder = {
    fg = get_hl(0, { name = "FloatBorder" }).fg,
    bg = nil,
  },
}

for name, opts in pairs(Highlight) do
  vim.api.nvim_set_hl(0, name, opts)
end

-- End --
