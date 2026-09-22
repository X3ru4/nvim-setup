local M = {}
local colorscheme = require('utils.colorscheme')

-- Add colorscheme in ~/.config/nvim/lua/plugins/themes/ press `gf` to open
colorscheme.install = {
	'base46',
	-- 'ember_theme', -- It is the file name
}

-- I recommend using base46 because it has more integration support and looks nicer
colorscheme.default = 'base46'
colorscheme.variant = 'base46-gruvchad'

---@type 'mini.indentscope'|'blink.indent'
vim.g.plugin_indent = 'mini.indentscope'

-- Quick configuration for blink.cmp
M.blinkcmp = {
	ghost_text = true,
	menu = {
		border = 'none',
		scrollbar = true,
	},
	documentation = {
		auto_show = false,
		border = 'solid',
		scrollbar = true,
	},
	appearance = {
		use_nvimcmp_hl = false,
	},
}

return M
