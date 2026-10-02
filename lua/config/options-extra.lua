local colorscheme = require('utils.colorscheme')

-- Add colorscheme in ~/.config/nvim/lua/plugins/themes/ press `gf` to open
colorscheme.install = {
	'base46',
	-- 'ember_theme', -- It is the file name
}

-- I recommend using base46 because it has more integration support and looks nicer
colorscheme.default = 'base46'
colorscheme.variant = 'base46-gruvbox_light'

---@type 'blink'|'mini'|'hlchunk'|any
vim.g.indent_guide = 'hlchunk'
---@type 'flat'|'rounded'|'square'|any
vim.g.ui_style = 'flat'
---@type 'default'|'atom'|'atom_colored'|'flat_light'|'flat_dark'|nil|false
vim.g.base46_cmp_style = 'flat_dark'

-- Quick configuration for blink.cmp
local blinkcmp = {
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

---@type [string, function]
local ui_styles = {
	flat = function()
		vim.opt.winborder = 'solid'
		blinkcmp.menu.border = 'none'
		blinkcmp.documentation.border = 'solid'
		vim.g.base46_cmp_style = 'flat_dark'
	end,
	rounded = function()
		vim.opt.winborder = 'rounded'
		blinkcmp.menu.border = 'rounded'
		blinkcmp.documentation.border = 'rounded'
		vim.g.base46_cmp_style = 'default'
	end,
	square = function()
		vim.opt.winborder = 'single'
		blinkcmp.menu.border = 'single'
		blinkcmp.documentation.border = 'single'
		vim.g.base46_cmp_style = 'default'
	end,
}

if ui_styles[vim.g.ui_style] then
	ui_styles[vim.g.ui_style]()
end

vim.g.blinkcmp = blinkcmp
