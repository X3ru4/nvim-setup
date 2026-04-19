local M = {}

local cache = {
	def = {},
	get = {},
}

---Clear caches
function M.clear_cache()
	cache.def = {}
	cache.get = {}
end

---This is the default table used to load highlights when M.apply() is called.
M.highlights = {}
---M.highlights_extra is used to load before M.highlights when M.apply() is called.
M.highlights_extra = {}

---Get the highlight but with the cache.
---Please use this function with M.set() to the best performance and no bug.
---@param name string Is the name of the highlight.
---@return table|vim.api.keyset.get_hl_info
function M.get(name)
	if not cache.get[name] then
		cache.get[name] = vim.api.nvim_get_hl(0, { name = name, link = false })
		return cache.get[name]
	else
		return cache.get[name]
	end
end

---Like M.get but return the forground color
function M.getfg(name)
	return M.get(name).fg
end
---Like M.get but return the background color
function M.getbg(name)
	return M.get(name).bg
end

local function inspect(t)
  local result = ""
  for k, v in pairs(t) do
    result = result .. k.. tostring(v)
  end
  return result
end

---Like the vim.api.nvim_set_hl() but with the cache.
---Please use this function with M.get() to the best performance.
---@param name string Name of highlight.
---@param opts vim.api.keyset.highlight Options
function M.set(name, opts)
	local key = name .. inspect(opts)
	if not cache.def[key] then
		vim.api.nvim_set_hl(0, name, opts)
		cache.get[name] = nil
		cache.def[key] = true
	end
end

---Modify highlight.
---@param name string The highlight name
---@param opts vim.api.keyset.highlight|function
---@param fallback boolean|nil If true the function will return a table.
---@return vim.api.keyset.highlight|nil|table
function M.modify(name, opts, fallback)
	if not M.hlexists(name) then
		return
	end
	local base = M.get(name) or {}
	if type(opts) == "function" then
		opts = opts(base) or {}
	end
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
	if not cache.def[ns] then
		local function pick_hl(arg, fallback_key)
			if not arg then
				return M.get(spec.default_hl)[fallback_key]
			end
			if type(arg) == "string" then
				return arg
			end

			if arg.list then
				return M.get(arg.list[arg.key] or arg.list[arg.default_key] or spec.default_hl)[arg[1] or fallback_key]
			elseif arg[1] then
				return M.get(arg[1])[arg[2] or fallback_key]
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
	if hex:byte(1) == 35 then -- #
		hex = hex:sub(2)
	end
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
	if type(dec_color) == "number" then
		return string.format("#%06X", dec_color)
	end
	vim.notify("Expected a number for dec_color, got " .. type(dec_color), vim.log.levels.WARN)
	return nil
end

--- Blends colors with an alpha value
--- @param foreground string|number color in hex format or number (e.g., "#RRGGBB" or 0xRRGGBB)
--- @param background string|number color in hex format or number (e.g., "#RRGGBB" or 0xRRGGBB)
--- @param alpha number alpha value between 0 (fully transparent) and 1 (fully opaque)
--- @return string|number|nil the resulting blended color in hex format
M.blend = function(foreground, background, alpha)
	if not foreground or not background then
		vim.notify("highlight.blend() was returned nil", vim.log.levels.WARN)
		return nil
	end

	foreground = type(foreground) == "number" and M.dec_to_hex(foreground) or foreground
	background = type(background) == "number" and M.dec_to_hex(background) or background
	local color1 = M.hex_to_rgb(foreground)
	local color2 = M.hex_to_rgb(background)

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
