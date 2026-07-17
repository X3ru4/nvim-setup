local M = {}
local hl = require("utility.highlight")

M.setup = function()
	local norm = {
		fg = hl.getfg("Normal") or hl.getfg("TroubleText"),
		bg = hl.getbg("Normal") or hl.getfg("Search"),
	}

	hl.set("Dark1", { fg = hl.blend(norm.bg, norm.fg, 0.9) })
	hl.set("Dark2", { fg = hl.blend(norm.bg, norm.fg, 0.8) })
	hl.set("Dark3", { fg = hl.blend(norm.bg, norm.fg, 0.7) })
	hl.set("Dark4", { fg = hl.blend(norm.bg, norm.fg, 0.6) })

	hl.highlights = {
		ModeOther = { link = "MiniStatuslineModeOther" },
		ModeNormal = { link = "MiniStatuslineModeNormal" },
		ModeInsert = { link = "MiniStatuslineModeInsert" },
		ModeVisual = { link = "MiniStatuslineModeVisual" },
		ModeCommand = { link = "MiniStatuslineModeCommand" },
		ModeReplace = { link = "MiniStatuslineModeReplace" },
	}

	hl.apply()
end

return M
