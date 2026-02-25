vim.loader.enable()

require("config.lazy")

local set_hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl
set_hl(0, "Red", { fg = "Red" })
set_hl(0, "Orange", { fg = "Orange" })
set_hl(0, "Yellow", { fg = "Yellow" })
set_hl(0, "Green", { fg = "Green" })
set_hl(0, "Aqua", { fg = "Aqua" })
set_hl(0, "Blue", { fg = "Blue" })
set_hl(0, "Purple", { fg = "Purple" })
