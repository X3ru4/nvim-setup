---@alias utility.highlight.hl_list_fun fun():string, table

---@class utility.highlight.highlights
---@field basic table|table<string, table>|nil
---@field extra table|[string, table][]|utility.highlight.hl_list_fun[]|nil
---@field callback table|function[]|nil

---@alias utility.highlight.advance_hl_style { [1]: string, [2]: string|nil }|{ [1]: string|nil, list: [string, string], key: string, default_key: string }

---@class utility.highlight.advance_hl_spec
---@field default_hl string|nil
---@field fg utility.highlight.advance_hl_style|string|nil
---@field bg utility.highlight.advance_hl_style|string|nil
---@field gui vim.api.keyset.highlight|nil

local cache = {
	def = {},
	get = {},
}

local M = {}

function M.clear_cache()
	cache.def = {}
	cache.get = {}
end

M.use_cache = false

---This is the default table used to load highlights when M.apply() is called.
M.highlight = {
	basic = {},
	extra = {},
	callback = {},
}

---Get the highlight but with the cache.
---@param name string
---@return vim.api.keyset.get_hl_info|table
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

---Like the vim.api.nvim_set_hl() but with the cache.
---@param name string
---@param opts vim.api.keyset.highlight|table
---@param force boolean|nil
function M.set(name, opts, force)
	if (force or opts.cforce) or not cache.def[name] then
		opts.cforce = nil
		vim.api.nvim_set_hl(0, name, opts)
		cache.get[name] = nil
		cache.def[name] = true
	end
end

---@param hl_list utility.highlight.highlights
function M.insert(hl_list)
	M.highlight = vim.tbl_deep_extend('force', M.highlight, hl_list)
	return M.highlight
end

---Modify highlight.
---@param name string The highlight name
---@param opts vim.api.keyset.highlight|fun(base:vim.api.keyset.get_hl_info):table
---@param append boolean|nil If true, it will be added to the M.highlight table.
---@return [string, table]
function M.modify(name, opts, append)
	if not M.hl_exist(name) then
		return {}
	end

	local base = M.get(name)
	if type(opts) == 'function' then
		opts = opts(base)
	else
		opts = vim.tbl_extend('force', base, opts)
	end

	M.highlight.basic[name] = append and opts or M.highlight.basic[name]
	return { name, opts }
end

---Apply highlights from `hl_list`. If `hl_list` is empty (nil), apply the M.highlights table instead.
---@param hl_list nil|utility.highlight.highlights
---@param use_cache boolean|nil
function M.apply(hl_list, use_cache)
	if not M.use_cache and not use_cache then
		M.clear_cache()
	end

	local t = (hl_list and hl_list ~= {}) and hl_list or M.highlight
	if t then
		if t.basic and t.basic ~= {} then
			for name, opts in pairs(t.basic) do
				M.set(name, opts)
			end
		end
		if t.extra and t.extra ~= {} then
			for _, val in ipairs(t.extra) do
				if type(val) == 'function' then
					M.set(val())
				else
					if val[1] and val[2] then
						M.set(val[1], val[2])
					end
				end
			end
		end
	end
end

---This function use to callback your function when highlight is load or reload.
---@param id string
---@param callback function
---@param overide boolean|nil
function M.add_callback(id, callback, overide)
	if not overide and M.highlight.callback[id] then
		M.highlight.callback[id]()
		return
	end
	callback()
	M.highlight.callback[id] = callback
end

function M.run_callbacks()
	if M.highlight.callback and M.highlight.callback ~= {} then
		for _, fn in pairs(M.highlight.callback) do
			fn()
		end
	end
end

local started = false

---Setup
---@param fn function
function M.setup(fn)
	if started then
		M.highlight.basic = {}
		M.highlight.extra = {}
	end
	fn()
	M.apply()
	M.run_callbacks()
	M.use_cache = true
	started = true
end

---Create your highlight!
---@param ns string Namespace
---@param spec utility.highlight.advance_hl_spec Spection
---@param get_opts boolean|nil Return the options instead of the highlight name.
---@return string|table
function M.advance_hl(ns, spec, get_opts)
	local function create_key(style)
		return type(style) == 'table' and style.list and (style.list[style.key] or '') or ''
	end

	ns = ns .. create_key(spec.fg) .. create_key(spec.bg)

	if not cache.def[ns] then
		local function pick_hl(style, key)
			if not style then
				return nil
			end
			if type(style) == 'string' or type(style) == 'number' then
				return style
			end

			if style.list then
				local group = style.list[style.key] or style.list[style.default_key] or spec.default_hl or 'Normal'
				return M.get(group)[style[1] or key]
			elseif style[1] then
				return M.get(style[1])[style[2] or key]
			end
		end

		local opts = vim.tbl_extend('keep', {
			fg = pick_hl(spec.fg, 'fg'),
			bg = pick_hl(spec.bg, 'bg'),
		}, spec.gui or {})
		if get_opts then
			return opts
		end
		M.set(ns, opts)
	end
	return ns
end

local function hex_to_rgb(hex)
	if hex:byte(1) == 35 then -- #
		hex = hex:sub(2)
	end
	return {
		r = tonumber(hex:sub(1, 2), 16),
		g = tonumber(hex:sub(3, 4), 16),
		b = tonumber(hex:sub(5, 6), 16),
	}
end

local function rgb_to_hex(rgb)
	return string.format('#%02x%02x%02x', rgb.r, rgb.g, rgb.b)
end

function M.dec_to_hex(dec_color)
	if type(dec_color) == 'number' then
		return string.format('#%06X', dec_color)
	end
	vim.notify('Expected a number for dec_color, got ' .. type(dec_color), vim.log.levels.WARN)
	return nil
end

--- Blends colors with an alpha value
--- @param foreground string|number
--- @param background string|number
--- @param alpha number
--- @return string|nil
M.blend = function(foreground, background, alpha)
	if not foreground or not background or not alpha then
		vim.notify('blend() returned nil', vim.log.levels.ERROR)
		return
	end

	foreground = type(foreground) == 'number' and M.dec_to_hex(foreground) or foreground
	background = type(background) == 'number' and M.dec_to_hex(background) or background
	local color1 = hex_to_rgb(foreground)
	local color2 = hex_to_rgb(background)

	-- Alpha blend formula: blended = alpha * color1 + (1 - alpha) * color2
	local r = math.floor(alpha * color1.r + (1 - alpha) * color2.r + 0.5)
	local g = math.floor(alpha * color1.g + (1 - alpha) * color2.g + 0.5)
	local b = math.floor(alpha * color1.b + (1 - alpha) * color2.b + 0.5)

	-- Clamp values between 0 and 255
	r = math.max(0, math.min(255, r))
	g = math.max(0, math.min(255, g))
	b = math.max(0, math.min(255, b))
	return rgb_to_hex({ r = r, g = g, b = b })
end

---@param name string
---@return boolean
function M.hl_exist(name)
	return not vim.tbl_isempty(M.get(name))
end

return M
