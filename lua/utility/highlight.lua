local M = {}

M.vset_hl = vim.api.nvim_set_hl
M.vget_hl = vim.api.nvim_get_hl

M.hl_def_cache = {}
M.hl_get_cache = {}

---Clear caches
function M.clear_cache()
	M.hl_def_cache = {}
	M.hl_get_cache = {}
end

---This is the default table used to load highlights when M.apply() is called.
M.highlights = {}
---M.highlights_extra is used to load before M.highlights when M.apply() is called.
M.highlights_extra = {}

---Get the highlight but with the cache.
---Please use this function with M.set() to the best performance and no bug.
---@param name string Is the name of the highlight.
---@param cache boolean|nil Default is true
---@return table|vim.api.keyset.get_hl_info
function M.get(name, cache)
	cache = cache or true
	if cache then
		if not M.hl_get_cache[name] then
			M.hl_get_cache[name] = M.vget_hl(0, { name = name, link = false })
			return M.hl_get_cache[name]
		else
			return M.hl_get_cache[name]
		end
	end
	return M.vget_hl(0, { name = name, link = false })
end

---Like the vim.api.nvim_set_hl() but with the cache.
---Please use this function with M.get() to the best performance.
---@param name string Name of highlight.
---@param opts vim.api.keyset.highlight Options
---@param cache boolean|nil Default is true
---@param  id number|nil
function M.set(name, opts, id, cache)
	cache = cache or true
	id = id or 0
	if cache then
		if not M.hl_def_cache[name] then
			M.vset_hl(id, name, opts)
			M.hl_get_cache[name] = nil
			M.hl_def_cache[name] = true
		end
	else
		M.vset_hl(id, name, opts)
	end
end

---Modify highlight.
---@param name string The highlight name
---@param opts vim.api.keyset.highlight
---@param fallback boolean|nil If true the function will return a table.
---@return vim.api.keyset.highlight|nil|table
function M.modify(name, opts, fallback)
	local base = M.get(name) or {}
	local merged = vim.tbl_extend("force", base, opts or {})

	if fallback then
		return merged
	else
		M.highlights[name] = merged
	end
end

---@param name string|table Name of colorscheme
---@param opts table|function|{ fn: function }
---@param apply boolean|nil Default is true
function M.set_match(name, opts, apply)
	local self = {}
	self.theme = vim.g.colors_name
	apply = apply or false

	local function match()
		local color = self.theme
		if color == nil then
			return
		end

		local function check_str(s)
			if s:match("!$") == "!" then
				s = s:match("(%w+)!$")
        self.variant = color:gsub(s, "")
				return color:match("^" .. s) == s
			elseif s:match("^!") then
				s = s:match("^!(%w+)")
        self.variant = color:gsub(s, "")
				return color:match(s .. "$") == s
			end
			return s == color
		end

		if type(name) == "table" then
			for _, c in ipairs(name) do
				if check_str(c) then
					return true
				end
			end
			return false
		end
		return check_str(name)
	end

	if match() then
		if type(opts) == "function" then
			M.highlights = vim.tbl_extend("force", M.highlights, opts(self) or {})
		elseif type(opts) == "table" then
			if type(opts.fn) == "function" then
				local fn = opts.fn(self)
				opts.fn = nil
				if type(fn) == "table" then
					opts = vim.tbl_extend("force", opts, fn)
				end
			end

			M.highlights = vim.tbl_extend("force", M.highlights, opts or {})
		end

		if apply then
			M.apply()
		end
	end
end

---Apply all highlights from M.highlights and other table.
---@param other table|function|nil
function M.apply(other)
	M.clear_cache()

	local function pair(t)
		if not t then
			return
		end
		if type(t) == "function" then
			t = t()
		end

		for name, opts in pairs(t) do
			if type(opts) == "function" then
				opts = opts()
			end

			M.set(name, opts)
		end
	end

	if other then
		pair(other)
	else
		pair(vim.tbl_extend("force", M.highlights, M.highlights_extra))
	end
end

---@alias hl_api.TextStyle
---|{
---  name:string,
---  type:"fg"|"bg"|nil,
---}
---|{
---  list:table,
---  key:string,
---  type:"fg"|"bg"|nil,
---}
---@alias hl_api.HlSpec
---|{
---  default_hl:string,
---  fg:hl_api.TextStyle|string|nil,
---  bg:hl_api.TextStyle|string|nil,
---  gui:vim.api.keyset.highlight|nil,
---}

---Create your highlight!
---@param ns string Namespace
---@param spec hl_api.HlSpec Spection
---@return string
function M.mix_hl(ns, spec)
	if not M.hl_def_cache[ns] then
		local function pick_hl(arg, fallback_key)
			if arg == nil then
				return M.get(spec.default_hl)[fallback_key]
			end
			if type(arg) == "string" then
				return arg
			end

			local type = arg.type or fallback_key
			if arg.name then
				return M.get(arg.name)[type]
			end
			if arg.list then
				return M.get(arg.list[arg.key] or arg.list[arg.default_key] or spec.default_hl)[type]
			end
		end

		local function create_key(arg)
			if arg then
				if arg.list then
					return arg.list[arg.key] or ""
				end
			end
			return ""
		end

		spec.default_hl = spec.default_hl or "Normal"

		ns = table.concat({
			ns,
			create_key(spec.fg),
			create_key(spec.bg),
		})
		M.set(
			ns,
			vim.tbl_extend("keep", {
				fg = pick_hl(spec.fg, "fg"),
				bg = pick_hl(spec.bg, "bg"),
			}, spec.gui or {})
		)
	end
	return ns
end

-- Helper to convert hex string to RGB table {r, g, b}
function M.hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return {
		r = tonumber(hex:sub(1, 2), 16),
		g = tonumber(hex:sub(3, 4), 16),
		b = tonumber(hex:sub(5, 6), 16),
	}
end

-- Helper to convert RGB table {r, g, b} to hex string
function M.rgb_to_hex(rgb)
	return string.format("#%02x%02x%02x", rgb.r, rgb.g, rgb.b)
end

function M.dec_to_hex(dec_color)
	if not dec_color then
		return nil
	end
	return string.format("#%06X", dec_color)
end

--- Blends colors with an alpha value
--- @param hex1 string color in hex format (e.g., "#RRGGBB")
--- @param hex2 string color in hex format (e.g., "#RRGGBB")
--- @param alpha number alpha value between 0 (fully transparent) and 1 (fully opaque)
--- @return string the resulting blended color in hex format
M.blend = function(hex1, hex2, alpha)
	local color1 = M.hex_to_rgb(hex1)
	local color2 = M.hex_to_rgb(hex2)

	-- Alpha blend formula: blended = alpha * color1 + (1 - alpha) * color2
	local r = math.floor(alpha * color1.r + (1 - alpha) * color2.r + 0.5)
	local g = math.floor(alpha * color1.g + (1 - alpha) * color2.g + 0.5)
	local b = math.floor(alpha * color1.b + (1 - alpha) * color2.b + 0.5)

	-- Clamp values between 0 and 255
	r = math.max(0, math.min(255, r))
	g = math.max(0, math.min(255, g))
	b = math.max(0, math.min(255, b))
	return M.rgb_to_hex({ r = r, g = g, b = b })
end

---Checking if that highlight is available
---@param hl string
---@return boolean
function M.hlexists(hl)
	return vim.fn.hlexists(hl) == 1
end

return M
