local M = {}
local line = require("utility.line")
local hl = require("utility.highlight")
local utils = require("heirline.utils")

local mode_color = {
	n = "ModeNormal",
	i = "ModeInsert",
	v = "ModeVisual",
	V = "ModeVisual",
	["\22"] = "ModeVisual",
	c = "ModeCommand",
	t = "ModeOther",
	R = "ModeReplace",
	s = "ModeVisual",
}

local hlsearch = {
	condition = function()
		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return string.format(" %d/%d ", search.current, math.min(search.total, search.maxcount))
	end,
	hl = "Number",
}
local mode = {
	init = function(self)
		self.mode = vim.fn.mode(1):sub(1, 1)
	end,
	static = {
		mode_name = {
			n = "Normal",
			i = "Insert",
			v = "Visual",
			V = "Visual-Line",
			["\22"] = "Visual-Block",
			c = "Command",
			t = "Terminal",
			R = "Replace",
			s = "Select",
		},
	},
	provider = function(self)
		return line.separator({
			default_hl = "StatusLine",
			id = "Mode",
			left = {
				value = " ",
				hl = {
					bg = {
						list = mode_color,
						default_key = "n",
						key = self.mode,
					},
				},
			},
			right = {
				value = "",
				hl = {
					fg = {
						list = mode_color,
						default_key = "n",
						key = self.mode,
						type = "bg",
					},
				},
			},
			string = {
				value = (self.mode_name[self.mode] or self.mode) .. " ",
				hl = {
					fg = { name = mode_color.i },
					bg = {
						list = mode_color,
						default_key = "n",
						key = self.mode,
					},
					style = { bold = true, italic = true },
				},
			},
		})
	end,
	update = {
		"ModeChanged",
		"BufModifiedSet",
	},
}
local macro = {
	condition = function()
		return vim.fn.reg_recording() ~= ""
	end,
	provider = function()
		return " [" .. vim.fn.reg_recording() .. "] "
	end,
	hl = "Type",
}
local diagnostic = {
	init = function(self)
		local count = vim.diagnostic.count(0)
		self.error = count[vim.diagnostic.severity.ERROR] or 0
		self.warn = count[vim.diagnostic.severity.WARN] or 0
		self.hint = count[vim.diagnostic.severity.HINT] or 0
		self.info = count[vim.diagnostic.severity.INFO] or 0
	end,
	update = "DiagnosticChanged",
	on_click = {
		name = "Diag",
		callback = require("fzf-lua").diagnostics_document,
	},
	provider = function(self)
		local icons = require("config.icons").diagnostic
		local check = function(c, s)
			return c > 0
					and table.concat({
						c,
						" %#Diagnostic",
						s,
						"#",
						icons[s],
						" %#StatusLine#",
					})
				or ""
		end
		return table.concat({
			check(self.error, "Error"),
			check(self.warn, "Warn"),
			check(self.hint, "Hint"),
			check(self.info, "Info"),
		})
	end,
}

M.config = function()
	local stl = vim.g.statusline_style

	hl.mix_hl("FileInfoMod", {
		default_hl = "StatusLine",
		fg = { name = "WarningMsg" },
		style = { bold = true },
	})
	hl.mix_hl("FileInfoRO", {
		default_hl = "StatusLine",
		fg = { name = "ErrorMsg" },
		style = { bold = true },
	})

	return {
		statusline = {
			mode,
			{
				provider = table.concat({
					" ",
					stl.file_name and "%t " or "",
					line.hl_fmt("FileInfoMod", stl.modify and "%m " or "", "%*"),
					line.hl_fmt("FileInfoRO", stl.read_only and "%r " or "", "%*"),
					"%=",
					stl.coordinate and "%l | %c " or "",
					stl.percent and "%p%% " or "",
					"%=",
				}),
			},
			stl.hlsearch and hlsearch,
			stl.macro and macro,
			stl.diagnostic and diagnostic,
		},
	}
end

return M
