return {
	'shellRaining/hlchunk.nvim',
	cond = vim.g.indent_guide == 'hlchunk',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local hl = require('utils.highlight')

		---@type HlChunk.UserChunkConf
		local chunk = {
			enable = true,
			style = function()
				return {
					hl.to_hex(hl.get_alias('Cyan', 'Function fg')),
					hl.to_hex(hl.get_alias('Red', 'ErrorMsg fg')),
				}
			end,
			textobject = 'ic',
			use_treesitter = true,
			-- animation related
			duration = 300, -- duration of the animation
			delay = 0, -- disable animation
		}
		---@type HlChunk.UserIndentConf
		local indent = {
			enable = true,
			style = function()
				return hl.to_hex(hl.get_alias('Line', 'NonText fg'))
			end,
		}

		require('hlchunk.mods.chunk')(chunk):enable()
		require('hlchunk.mods.indent')(indent):enable()
	end,
}
