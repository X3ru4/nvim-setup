local hl = require('utils.highlight')

local function set_hl_mode(mode, link, fallback)
	if hl.hl_exist(link) then
		return { 'Mode' .. mode, { link = link, default = true } }
	end
	return {
		'Mode' .. mode,
		{
			default = true,
			fg = hl.alias.Black,
			bg = hl.getfg(fallback),
			bold = true,
		},
	}
end

hl.setup(function()
	-- These aliases are primarily used for heirline.nvim and fzf-lua
	hl.alias.White = hl.getfg('Normal') or hl.getfg('@text')
	hl.alias.Black = hl.getbg('Normal') or hl.getbg('StatusLine')

	hl.alias.Black1 = hl.blend(hl.alias.Black, hl.alias.White, 0.9)
	hl.alias.Black2 = hl.blend(hl.alias.Black, hl.alias.White, 0.8)
	hl.alias.Black3 = hl.blend(hl.alias.Black, hl.alias.White, 0.7)
	hl.alias.Black4 = hl.blend(hl.alias.Black, hl.alias.White, 0.6)

	hl.insert({
		-- All highlights are cached, so use `_force = true` to ignore them.
		-- Normal = { _force = true, fg = '#ffee00', bg = '#3a3b2f' },
		Yank = {
			bg = hl.blend(hl.getbg('IncSearch'), hl.alias.Black, 0.25),
		},
		Paste = {
			bg = hl.blend(hl.getfg('Added'), hl.alias.Black, 0.25),
		},
		MCursor = { link = 'Cursor' },
		-- Create highlights for the basic Vim/Nvim modes used in heirline.nvim.
		set_hl_mode('Other', 'MiniStatuslineModeOther', 'Function'),
		set_hl_mode('Normal', 'MiniStatuslineModeNormal', 'DiagnosticSignInfo'),
		set_hl_mode('Insert', 'MiniStatuslineModeInsert', 'Added'),
		set_hl_mode('Visual', 'MiniStatuslineModeVisual', 'DiagnosticSignWarn'),
		set_hl_mode('Command', 'MiniStatuslineModeCommand', 'Removed'),
		set_hl_mode('Replace', 'MiniStatuslineModeReplace', 'DiagnosticSignError'),
		-- Modify default highlights.
		hl.modify('Visual', { bold = false }),
		-- hl.modify('FloatTitle', { bg = hl.getbg('NormalFloat') }),
		hl.modify('FloatBorder', { bg = hl.getbg('NormalFloat'), _force = true }),
		-- function ()
		-- 	return 'Abc', {} -- name, opts
		-- end
	})
end)
