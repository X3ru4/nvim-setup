return {
	'rachartier/tiny-cmdline.nvim',
	event = 'UIEnter',
	init = function()
		require('vim._core.ui2').enable()
		vim.o.cmdheight = 0
	end,
	config = function()
		require('tiny-cmdline').setup({
			border = nil,
			native_types = { '/', '?' },
			title = {
				enabled = true,
				pos = 'center',
				formats = {
					{ type = ':', pattern = { '^%s*lua%s+', '^%s*lua%s*=', '^%s*=' }, title = ' 󰢱 Lua ' },
					{ type = ':', pattern = '^%s*!', title = '  Shell ' },
					{ type = ':', pattern = '^%s*he?l?p?%s+', title = '  Help ' },
					{ type = ':', pattern = '^%s*color?s?c?h?e?m?e?%s+', title = '  Colorscheme ' },
					{ type = ':', pattern = '^%s*IncRename%s+', title = '  Rename ' },
					{ title = ' 󰍳 CmdLine ' },
				},
			},
		})

		local hl = require('utils.highlight')
		hl.add_callback('tiny-cmdline', function()
			hl.set('TinyCmdlineNormal', { link = 'NormalFloat' })
		end)
	end,
}
