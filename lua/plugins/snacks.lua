local ft = {
	markdown = false,
	lua = true,
}

-- I only use the indent module =))
return {
	'folke/snacks.nvim',
	event = { 'BufReadPost', 'BufNewFile' },
	opts = {
		indent = {
			enabled = true,
			chunk = {
				enabled = true,
				char = {
					corner_top = '╭',
					corner_bottom = '╰',
					horizontal = '─',
					vertical = '│',
					arrow = '󰅂',
				},
			},
			---@param buf number
			---@param _ number -- win id
			filter = function(buf, _)
				return vim.g.snacks_indent ~= false
					and vim.b[buf].snacks_indent ~= false
					and vim.bo[buf].buftype == ''
					and ft[vim.bo[buf].filetype] ~= false
			end,
		},
	},
}
