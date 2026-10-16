return {
	'rachartier/tiny-cmdline.nvim',
	event = 'UIEnter',
	init = function()
		vim.o.cmdheight = 0
		require('vim._core.ui2').enable()
	end,
	config = function()
		local formats = {
			{ type = ':', pattern = { '^%s*lua%s+', '^%s*lua%s*=', '^%s*=' }, title = '  Lua ' },
			{ type = ':', pattern = '^%s*!', title = '  Shell ' },
			{ type = ':', pattern = '^%s*he?l?p?%s+', title = '  Help ' },
			{ type = ':', pattern = '^%s*color?s?c?h?e?m?e?%s+', title = ' 󱥚 Colorscheme ' },
			{ type = ':', pattern = '^%s*chec?k?h?e?a?l?t?h?%s+', title = '  Checkhealth ' },
			{ type = '@', title = '  Input ' },
			{ title = '  Cmdline ' },
		}

		-- only take the text part (%w+)
		if not vime.has_nerdfont then
			for _, v in ipairs(formats) do
				v.title = ' ' .. v.title:match('%w+') .. ' '
			end
		end

		---@diagnostic disable-next-line: missing-fields
		require('tiny-cmdline').setup({
			border = nil,
			native_types = { '/', '?' },
			title = {
				enabled = true,
				pos = 'center',
				formats = formats,
			},
		})

		local hl = require('utils.highlight')
		hl.add_hook('tiny-cmdline', function()
			hl.set('TinyCmdlineNormal', { link = 'Pmenu' })
			hl.set('TinyCmdlineBorder', { fg = hl.getfg('FloatBorder'), bg = hl.getbg('Pmenu') })
		end)
	end,
}
