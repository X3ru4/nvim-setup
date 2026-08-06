local hl = vimu.highlight

hl.setup(function()
	local norm = {
		fg = hl.getfg('Normal') or hl.getfg('Cursor'),
		bg = hl.getbg('Normal') or hl.getbg('Cursor'),
	}

	hl.set('Dark1', { fg = hl.blend(norm.bg, norm.fg, 0.9) })
	hl.set('Dark2', { fg = hl.blend(norm.bg, norm.fg, 0.8) })
	hl.set('Dark3', { fg = hl.blend(norm.bg, norm.fg, 0.7) })
	hl.set('Dark4', { fg = hl.blend(norm.bg, norm.fg, 0.6) })

	local function create_modehl(name, ref, def)
		if hl.hl_exist(name) then
			return {}
		end
		if hl.hl_exist(ref) then
			return { name, { link = ref } }
		end
		return { name, { fg = norm.bg, bg = hl.getfg(def), bold = true } }
	end

	hl.insert({
		-- This field is used to set up simple highlighting.
		basic = {
			-- All highlights are cached, so use `cforce = true` to ignore them.
			-- Normal = { cforce = true, fg = "#ffee00", bg = "#3a3b2f" }
			Yank = { link = 'Visual' },
		},
		-- This field is a special field used to set up highlights that require logic.
		extra = {
			-- Create highlights for the basic Vim/Nvim modes used in heirline.nvim.
			create_modehl('ModeOther', 'MiniStatuslineModeOther', 'DiagnosticInfo'),
			create_modehl('ModeNormal', 'MiniStatuslineModeNormal', 'DiagnosticInfo'),
			create_modehl('ModeInsert', 'MiniStatuslineModeInsert', 'DiagnosticOk'),
			create_modehl('ModeVisual', 'MiniStatuslineModeVisual', 'DiagnosticWarn'),
			create_modehl('ModeCommand', 'MiniStatuslineModeCommand', 'DiagnosticError'),
			create_modehl('ModeReplace', 'MiniStatuslineModeReplace', 'DiagnosticError'),
			-- Modify default highlights.
			hl.modify('Visual', { bold = true }),
			-- hl.modify("FloatTitle", { bg = hl.getbg("NormalFloat") }),
			hl.modify('FloatBorder', { bg = hl.getbg('NormalFloat'), cforce = true }),
			-- function ()
			-- 	return "Abc", {} -- name, opts
			-- end
		},
	})
end)
