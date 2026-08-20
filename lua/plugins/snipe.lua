return {
	'leath-dub/snipe.nvim',
	keys = {
		{
			'gb',
			function()
				require('snipe').open_buffer_menu()
			end,
			desc = 'Open Snipe buffer menu',
		},
	},
	opts = {
		ui = {
			position = 'center',
			text_align = 'left',
			buffer_format = {
				function(buf)
					local dir = vim.fs.basename(vim.fs.dirname(buf.name))
					return dir .. '/', 'SnipeDirname'
				end,
				'filename',
				function(buf)
					return ' ' .. buf.classifiers:gsub('%s+', ''), 'WarningMsg'
				end,
			},

			---@type vim.api.keyset.win_config
			open_win_override = {
				border = vim.o.winborder,
				title = ' Snipe ',
			},
		},

		navigate = {
			---@type string|string[]
			cancel_snipe = { '<esc>', 'q' },
		},
	},
}
