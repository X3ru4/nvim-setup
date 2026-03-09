local M = {}
local line = require("utility.line")
local hl = require("utility.highlight")

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
	update = { "ModeChanged" },
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
		-- Classic sep: "" | "" | "" | "" | ""
		-- Special sep: "" | "" | ""
		local sep = ""
		hl.set("ModeSep2", {
			fg = hl.get("Dark2").fg,
		})
		hl.set("ModeSep1", {
			fg = hl.get("Dark4").fg,
			bg = hl.get("ModeSep2").fg,
		})

		local fg_opt = {}
		if vim.g.colors_name == "base46" then
			fg_opt = { name = "Dark0", type = "fg" }
		else
			fg_opt = { name = "Normal", type = "bg" }
		end

		local section = {
			line.separator({
				id = "Mode",
				left = {
					value = "  ",
					hl = {
						fg = fg_opt,
						bg = {
							list = mode_color,
							default_key = "n",
							key = self.mode,
						},
					},
				},
				right = {
					value = sep,
					hl = {
						fg = {
							list = mode_color,
							default_key = "n",
							key = self.mode,
							type = "bg",
						},
						bg = { name = "ModeSep1", type = "fg" },
					},
				},
				string = {
					value = (self.mode_name[self.mode] or self.mode) .. " ",
					hl = {
						fg = fg_opt,
						bg = {
							list = mode_color,
							default_key = "n",
							key = self.mode,
						},
						gui = { bold = true, italic = true },
					},
				},
			}),
			line.hl_fmt("ModeSep1", sep),
			line.hl_fmt("ModeSep2", sep),
		}

		return table.concat(section)
	end,
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
	update = { "DiagnosticChanged" },
	static = {
		icons = require("config.icons").diagnostic,
	},
	init = function(self)
		local count = vim.diagnostic.count(0)

		self.error = count[vim.diagnostic.severity.ERROR] or 0
		self.warn = count[vim.diagnostic.severity.WARN] or 0
		self.hint = count[vim.diagnostic.severity.HINT] or 0
		self.info = count[vim.diagnostic.severity.INFO] or 0

		self.diagnostic = {
			{ count = self.error, icon = self.icons.Error, icon_hl = "DiagnosticError" },
			{ count = self.warn, icon = self.icons.Warn, icon_hl = "DiagnosticWarn" },
			{ count = self.hint, icon = self.icons.Hint, icon_hl = "DiagnosticHint" },
			{ count = self.info, icon = self.icons.Info, icon_hl = "DiagnosticInfo" },
		}
	end,
	provider = function(self)
		local t = {}
		for _, info in ipairs(self.diagnostic) do
			if info.count > 0 then
				t[#t + 1] = string.format("%s %%#%s#%s %%#StatusLine#", info.count, info.icon_hl, info.icon)
			end
		end

		return table.concat(t)
	end,
}

M.config = function()
	-- Quick config. Go to lua/config/options.lua to see more.
	local stl = vim.g.statusline_style

	return {
		statusline = {
			mode,
			{ provider = " " },
			-- File name
			{ update = "BufWinEnter", provider = stl.file_name and "%t " or "" },
			-- File modify
			{
				update = "BufModifiedSet",
				provider = function()
					hl.set("FileInfoMod", {
						fg = hl.get("WarningMsg").fg,
						bold = true,
					})
					return line.hl_fmt("FileInfoMod", stl.modify and "%m " or "", "%*")
				end,
			},
			-- Read only buffer
			{
				update = "BufWinEnter",
				provider = function()
					hl.set("FileInfoRO", {
						fg = hl.get("ErrorMsg").fg,
						bold = true,
					})
					return line.hl_fmt("FileInfoRO", stl.read_only and "%r " or "", "%*")
				end,
			},
			{ provider = "%=" },
			-- Cursor position row/col
			{ update = { "CursorMoved", "CursorMovedI" }, provider = stl.coordinate and "%l|%c " or "" },
			{ update = { "CursorMoved", "CursorMovedI" }, provider = stl.percent and "%p%% " or "" },
			{ provider = "%=" },
			stl.hlsearch and hlsearch,
			stl.macro and macro,
			stl.diagnostic and diagnostic,
		},
	}
end

return M
