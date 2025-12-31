local M = {}
local vset_hl = vim.api.nvim_set_hl
local vget_hl = vim.api.nvim_get_hl
local hl_def_cache = {}
local hl_link_cache = {}

local tbl_clear = function(t)
	for k, _ in pairs(t) do
		t[k] = nil
	end
end

M.debug = function()
	for key, value in pairs(hl_def_cache) do
		print(key, value, "\n")
	end
end

M.clear = function()
	tbl_clear(hl_def_cache)
	tbl_clear(hl_link_cache)
end

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

local separator = function(spec)
	local hl_fmt = function(hl_name)
		return "%#" .. hl_name .. "#"
	end
	if not spec.id then
		vim.notify("separator({ id = ? })")
	end
	local hl_ns = "HeirLineSep" .. (spec.id or "nil")
	local ensure_hl = function(id, hl)
		local hl_name = hl_ns .. id
		local pick_hl = function(src, fallback_key)
			if src == nil then
				if not hl_link_cache.StatusLine then
					hl_link_cache.StatusLine = vget_hl(0, { name = "StatusLine" })
				end
				return hl_link_cache.StatusLine[fallback_key]
			end
			if src.name then
				if not hl_link_cache[src.name] then
					hl_link_cache[src.name] = vget_hl(0, { name = src.name })
				end
				return hl_link_cache[src.name][src.type or fallback_key]
			end
			if src.list then
				for _, v in pairs(src.list) do
					if not hl_link_cache[v] then
						hl_link_cache[v] = vget_hl(0, { name = v })
					end
				end
				return hl_link_cache[src.list[src.use]][src.type or fallback_key]
			end
			if type(src) == "string" then
				if not hl_link_cache[src] then
					hl_link_cache[src] = vget_hl(0, { name = src })
				end
				return hl_link_cache[src][fallback_key]
			end
		end
		local create_key = function(src)
			if src then
				if src.list then
					return src.list[src.use]
				end
			end
			return ""
		end
		hl_name = table.concat({
			hl_name,
			create_key(hl.fg),
			create_key(hl.bg),
		})
		if not hl_def_cache[hl_name] then
			vset_hl(
				0,
				hl_name,
				vim.tbl_extend("keep", {
					fg = pick_hl(hl.fg, "fg"),
					bg = pick_hl(hl.bg, "bg"),
				}, hl.style or {})
			)
			hl_def_cache[hl_name] = true
		end
		return hl_fmt(hl_name)
	end
	local section_fmt = function(section, id)
		if type(section) == "table" then
			if type(section.hl) == "string" then
				return hl_fmt(section.hl) .. section.value
			elseif section.hl == nil then
				return hl_fmt("StatusLine") .. section.value
			end
			return ensure_hl(id, section.hl) .. section.value
		end
		return ""
	end
	return table.concat({
		section_fmt(spec.left, "0"),
		section_fmt(spec.string, "1"),
		section_fmt(spec.right, "2"),
		hl_fmt("StatusLine"),
	})
end

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
	hl = "StatusLine",
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
		return separator({
			id = "Mode",
			left = {
				value = " ",
				hl = {
					bg = {
						list = mode_color,
						use = self.mode,
					},
				},
			},
			right = {
				value = vim.o.cmdheight == 0 and "" or "",
				hl = {
					fg = {
						list = mode_color,
						use = self.mode,
						type = "bg",
					},
					bg = {
						list = {
							true_ = "TabLine",
							false_ = "Nop",
						},
						use = tostring(vim.bo.modified) .. "_",
					},
				},
			},
			string = {
				value = self.mode_name[self.mode] .. " ",
				hl = {
					fg = mode_color.i,
					bg = {
						list = mode_color,
						use = self.mode,
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
local modified = {
	condition = function()
		return vim.bo.modified
	end,
	provider = function()
		return separator({
			id = "Modified",
			string = {
				value = " Modified ",
				hl = {
          fg = "WarningMsg",
					bg = "TabLine",
					style = { italic = true },
				},
			},
			right = {
				value = "",
				hl = { fg = { name = "TabLine", type = "bg" } },
			},
		})
	end,
}
local macro = {
	condition = function()
		return vim.fn.reg_recording() ~= ""
	end,
	provider = function()
		return " " .. vim.fn.reg_recording() .. " "
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
	provider = function(self)
		local icons = require("config.icons").diagnostic
		local check = function(c, s)
			return c > 0
					and table.concat({
						"%#Diagnostic",
						s,
						"#",
						icons[s],
						" %#StatusLine#",
						c,
						" ",
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
local custom = {
	provider = function()
		return separator({
			id = "Custom",
			left = {
				value = "",
				hl = { fg = { name = "TabLine", type = "bg" } },
			},
			string = {
				value = " 𝑋3𝑟𝑢4 ",
				hl = {
					fg = { name = "String" },
					bg = { name = "TabLine", type = "bg" },
          style = { bold = false }
				},
			},
		})
	end,
}

M.config = {
	statusline = {
		mode,
		modified,
		{ provider = "%=" },
		hlsearch,
		macro,
		diagnostic,
		custom,
	},
}
return M
