local hl = require('utils.highlight')

hl.setup(function()
	-- These aliases are primarily used for heirline.nvim and fzf-lua
	hl.alias.White = hl.getfg('Normal') or hl.getfg('Cursor')
	hl.alias.Black = hl.getbg('Normal') or hl.getbg('Cursor')

	hl.alias.Black1 = hl.blend(hl.alias.Black, hl.alias.White, 0.9)
	hl.alias.Black2 = hl.blend(hl.alias.Black, hl.alias.White, 0.8)
	hl.alias.Black3 = hl.blend(hl.alias.Black, hl.alias.White, 0.7)
	hl.alias.Black4 = hl.blend(hl.alias.Black, hl.alias.White, 0.6)

	local function set_modehl(mode, hlname, fallback)
		if hl.hl_exist(hlname) then
			return { 'Mode' .. mode, { link = hlname, default = true } }
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

	hl.insert({
		-- This table is used to set up simple highlighting.
		[1] = {
			-- All highlights are cached, so use `cforce = true` to ignore them.
			-- Normal = { cforce = true, fg = '#ffee00', bg = '#3a3b2f' },
			Yank = {
				fg = hl.getbg('IncSearch'),
				bg = hl.blend(hl.getbg('IncSearch'), hl.alias.Black, 0.3),
				bold = true,
			},
		},
		-- This table is a special table used to set up highlights that require logic.
		[2] = {
			-- Create highlights for the basic Vim/Nvim modes used in heirline.nvim.
			set_modehl('Other', 'MiniStatuslineModeOther', 'DiagnosticSignInfo'),
			set_modehl('Normal', 'MiniStatuslineModeNormal', 'DiagnosticSignInfo'),
			set_modehl('Insert', 'MiniStatuslineModeInsert', 'DiagnosticSignOk'),
			set_modehl('Visual', 'MiniStatuslineModeVisual', 'DiagnosticSignWarn'),
			set_modehl('Command', 'MiniStatuslineModeCommand', 'DiagnosticSignError'),
			set_modehl('Replace', 'MiniStatuslineModeReplace', 'DiagnosticSignError'),
			-- Modify default highlights.
			hl.modify('Visual', { bold = true }),
			-- hl.modify('FloatTitle', { bg = hl.getbg('NormalFloat') }),
			hl.modify('FloatBorder', { bg = hl.getbg('NormalFloat'), cforce = true }),
			-- function ()
			-- 	return 'Abc', {} -- name, opts
			-- end
		},
	})
end)
