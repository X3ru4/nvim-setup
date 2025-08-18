local function get(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

local highlight = {
  WinBar = {
    fg = vim.g.color_palette.yellow,
    bg = vim.g.color_palette.bg2,
    bold = true
  },
  WinBarNC = {
    fg = vim.g.color_palette.yellow,
    bg = vim.g.color_palette.bg2,
    bold = true
  },
  BufferLineModified = {
    fg = vim.g.color_palette.fg
  },
  BufferLineModifiedSelected = {
    fg = vim.g.color_palette.fg
  }
}

-- apply highlight
for name, opts in pairs(highlight) do
  vim.api.nvim_set_hl(0, name, opts)
end
