return {
	'rachartier/tiny-cmdline.nvim',
	event = 'UIEnter',
	priority = 1000,
	config = function()
		vim.o.cmdheight = 0
		require('tiny-cmdline').setup({
			on_reposition = require('tiny-cmdline').adapters.blink,
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
					{ type = '/', title = '  Search ' },
					{ type = '?', title = '  Search ' },
					{ title = ' 󰍳 CmdLine ' },
				},
			},
		})

		vimu.highlight.add_callback('tiny-cmdline', function()
			vimu.highlight.set('TinyCmdlineNormal', { link = 'NormalFloat' })
		end)
	end,
}
