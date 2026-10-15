local colorscheme = require('utils.colorscheme')

-- Add colorscheme in ~/.config/nvim/lua/plugins/themes/ press `gf` to open
colorscheme.install = {
	'base46',
	-- 'ember_theme', -- It is the file name
}

-- I recommend using base46 because it has more integration support and looks nicer
colorscheme.default = 'base46'
colorscheme.variant = 'base46-gruvbox_light'

---NvimExtra
_G.nve = {
	---@type boolean
	has_nerdfont = true, -- This helps identify if you're using Nerdfont; otherwise, it will use the glyphs that the font supports.
	---@type 'blink'|'mini'|'hlchunk'|any
	indent_guide = 'blink',
	---@type 'thin'|'thick'|'middle'|'dashed'|'dashed2'|any
	indent_guide_style = 'thin',
	---@type 'flat'|'rounded'|'square'|'combine'|any
	ui_style = 'combine',
	---@type 'default'|'atom'|'atom_colored'|'flat_light'|'flat_dark'|nil|false
	base46_cmp_style = 'flat_dark', -- Only works with `base46` colorscheme
	-- Quick configuration for blink.cmp
	blinkcmp = {
		ghost_text = true,
		menu = {
			border = 'none',
			scrollbar = false,
		},
		documentation = {
			auto_show = false,
			border = 'solid',
			scrollbar = true,
		},
		appearance = {
			use_nvimcmp_hl = false,
		},
	},
}

local blinkcmp = nve.blinkcmp

---@type [string, function]
local ui_styles = {
	flat = function()
		vim.opt.winborder = 'solid'
		blinkcmp.menu.border = 'none'
		blinkcmp.documentation.border = 'solid'
		nve.base46_cmp_style = 'flat_dark'
	end,
	rounded = function()
		vim.opt.winborder = 'rounded'
		blinkcmp.menu.border = 'rounded'
		blinkcmp.documentation.border = 'rounded'
		nve.base46_cmp_style = 'default'
	end,
	square = function()
		vim.opt.winborder = 'single'
		blinkcmp.menu.border = 'single'
		blinkcmp.documentation.border = 'single'
		nve.base46_cmp_style = 'default'
	end,
	combine = function()
		vim.opt.winborder = 'rounded'
		blinkcmp.menu.border = 'none'
		blinkcmp.documentation.border = 'solid'
		nve.base46_cmp_style = 'flat_dark'
	end,
}

local ig_chars = {
	thin = '▏',
	thick = '▎',
	middle = '│',
	dashed = '┆',
	dashed2 = '┊',
}

if ui_styles[nve.ui_style] then
	ui_styles[nve.ui_style]()
end

nve.indent_guide_char = ig_chars[nve.indent_guide_style] or '│'
