local get_hl = vim.api.nvim_get_hl
local set_hl = vim.api.nvim_set_hl

set_hl(0, "Pmenu", {
  blend = _G.blend,
})
