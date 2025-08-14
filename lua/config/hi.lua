-- Highlight

local get = vim.api.nvim_get_hl
local function qget(name, opts)
  return get(0, { name = name, opts })
end

local Highlight = {
  BlinkCmpMenuSelection = {
    link = "PmenuSel",
  },
}

for name, opts in pairs(Highlight) do
  vim.api.nvim_set_hl(0, name, opts)
end

-- End --
