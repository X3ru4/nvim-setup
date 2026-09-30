return {
	'shellRaining/hlchunk.nvim',
	cond = vim.g.indent_guide == 'hlchunk',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		---@type HlChunk.UserChunkConf
		local chunk = {
			enable = true,
			textobject = 'ic',
			use_treesitter = true,
			-- animation related
			duration = 300, -- duration of the animation
			delay = 0, -- disable animation
		}
		---@type HlChunk.UserIndentConf
		local indent = { enable = true }

		require('hlchunk.mods.chunk')(chunk):enable()
		require('hlchunk.mods.indent')(indent):enable()

		local hl = require('utils.highlight')
		hl.set('HLChunk1', { fg = hl.get_alias('Cyan', 'Function fg') })
		hl.set('HLChunk2', { fg = hl.get_alias('Red', 'ErrorMsg fg') })
		hl.set('HLIndent1', { fg = hl.get_alias('Line', 'NonText fg') })
	end,
}
