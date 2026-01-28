local M = {}
local line = require("util.line")
local hl_api = require("util.hl_api")
local utils = require("heirline.utils")

local mode_color = {
	n = "MiniStatuslineModeNormal",
	i = "MiniStatuslineModeInsert",
	v = "MiniStatuslineModeVisual",
	V = "MiniStatuslineModeVisual",
	["\22"] = "MiniStatuslineModeVisual",
	c = "MiniStatuslineModeCommand",
	t = "MiniStatuslineModeOther",
	R = "MiniStatuslineModeReplace",
	s = "MiniStatuslineModeVisual",
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
					style = { bold = true },
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

local stl = vim.g.statusline_style

M.config = {
	statusline = {
		mode,
		{
			provider = table.concat({
				" ",
				stl.file_name and "%t " or "",
				line.hl_fmt("WarningMsg", stl.modify and "%m " or "", "%*"),
				line.hl_fmt("ErrorMsg", stl.read_only and "%r " or "", "%*"),
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

return M
