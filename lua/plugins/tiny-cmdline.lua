return {
	'rachartier/tiny-cmdline.nvim',
	event = 'UIEnter',
	init = function()
		vim.o.cmdheight = 0
		require('vim._core.ui2').enable()
	end,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require('tiny-cmdline').setup({
			border = nil,
			native_types = { '/', '?' },
			title = {
				enabled = true,
				pos = 'center',
				formats = {
					{ type = ':', pattern = { '^%s*lua%s+', '^%s*lua%s*=', '^%s*=' }, title = '  Lua ' },
					{ type = ':', pattern = '^%s*!', title = '  Shell ' },
					{ type = ':', pattern = '^%s*he?l?p?%s+', title = '  Help ' },
					{ type = ':', pattern = '^%s*color?s?c?h?e?m?e?%s+', title = ' 󱥚 Colorscheme ' },
					{ title = '  Cmdline ' },
				},
			},
		})

		local hl = require('utils.highlight')
		hl.add_hook('tiny-cmdline', function()
			hl.set('TinyCmdlineNormal', { link = 'Pmenu' })
			hl.set('TinyCmdlineTitle', { fg = hl.alias.Black, bg = hl.getfg('Function') })
			hl.set('TinyCmdlineBorder', { link = 'Pmenu' })
		end)
	end,
}
