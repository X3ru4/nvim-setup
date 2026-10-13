local cache = {
	def = {},
	get = {},
}

local M = {}

M.alias = {}
M.use_cache = true

---This is the default table used to load highlights when M.apply() is called.
M.data = {
	[1] = {},
	__callbacks = {},
	__next_time = {},
}

function M.clear_cache()
	cache.def = {}
	cache.get = {}
end

---Get the highlight but with the cache.
---@param name string
---@param ns_id number?
---@return vim.api.keyset.get_hl_info|table
function M.get(name, ns_id)
	local _ns_id = ns_id or 'global'
	cache.get[_ns_id] = cache.get[_ns_id] or {}
	if not cache.get[_ns_id][name] then
		cache.get[_ns_id][name] = vim.api.nvim_get_hl(ns_id or 0, { name = name, link = false })
		return cache.get[_ns_id][name]
	else
		return cache.get[_ns_id][name]
	end
end

---Get alias value
---@param name string
---@param fallback string?
---@return string|number|nil
function M.get_alias(name, fallback)
	if M.alias[name] then
		return M.alias[name]
	else
		if fallback then
			local hl = vim.split(fallback, ' ', { plain = true })
			return M.get(hl[1])[hl[2]]
		end
	end
end

function M.set_alias(name, value, default)
	if default and M.alias[name] then
		return
	end

	M.alias[name] = value
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
---@param opts vim.api.keyset.highlight|table|{ _force: boolean?, ns_id: number? }
---@param force boolean?
function M.set(name, opts, force)
	local ns_id = opts.ns_id or 'global'
	cache.def[ns_id] = cache.def[ns_id] or {}
	if (force or opts._force) or not cache.def[ns_id][name] then
		opts._force = nil
		opts.ns_id = nil
		cache.get[ns_id] = cache.get[ns_id] or {}
		vim.api.nvim_set_hl(opts.ns_id or 0, name, opts)
		cache.get[ns_id][name] = nil
		cache.def[ns_id][name] = true
	end
end

---@param hl_list utility.highlight.highlights
---@param behavior 'error'|'keep'|'force'? Decides what to do if a key is found in more than one map:
---      - 'error': raise an error
---      - 'force': use value from the rightmost map
---      - 'keep':  use value from the leftmost map
function M.insert(hl_list, behavior)
	M.data[1] = vim.tbl_deep_extend(behavior or 'force', M.data[1], hl_list)
	return M.data[1]
end

---Modify highlight.
---@param name string The highlight name
---@param opts vim.api.keyset.highlight|fun(base:vim.api.keyset.get_hl_info):table
---@param append boolean? If true, it will be added to the M.data[1] table.
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

	if append then
		M.data[1][name] = opts
	end

	return { name, opts }
end

---Apply highlights from `hl_list`. If `hl_list` is empty (nil), apply the M.data[1] table instead.
---@param hl_list nil|utility.highlight.highlights
---@param no_cache boolean?
function M.apply(hl_list, no_cache)
	local data = (hl_list and hl_list ~= {}) and hl_list or M.data[1]
	if data and data ~= {} then
		for name, opts in pairs(data) do
			if type(name) == 'number' then
				if type(opts) == 'function' then
					local hl, hl_opts = opts()
					if no_cache then
						cache.def[hl] = nil
					end
					M.set(hl, hl_opts)
				else
					if opts[1] and opts[2] then
						if no_cache then
							cache.def[opts[1]] = nil
						end
						M.set(opts[1], opts[2])
					end
				end
			else
				if no_cache then
					cache.def[name] = nil
				end
				M.set(name, opts)
			end
		end
	end
end

---This function use to callback your function when highlight is load or reload.
---@param id string
---@param callback function
---@param next_time boolean?
---@param init boolean?
function M.add_hook(id, callback, next_time, init)
	if init then
		callback()
	end

	if next_time then
		M.data.__next_time[id] = true
	end
	M.data.__callbacks[id] = callback
end

local started = false

function M.run_hooks()
	if M.data.__callbacks and M.data.__callbacks ~= {} then
		for id, callback in pairs(M.data.__callbacks) do
			if M.data.__next_time[id] then
				if started then
					callback()
				end
			else
				callback()
			end
		end
	end
end

---Setup
---@param config function|table
function M.setup(config)
	if started then
		M.data[1] = {}
	end

	if not M.use_cache then
		M.clear_cache()
	end

	if type(config) == 'function' then
		config(M.data[1])
	else
		M.insert(config)
	end

	M.apply()
	M.run_hooks()
	M.use_cache, started = true, true
end

---Convert numerical color codes to hexadecimal color codes.
function M.to_hex(dec)
	return type(dec) == 'number' and string.format('#%06X', dec) or dec
end

local function rgb_to_hex(r, g, b)
	return string.format('#%02x%02x%02x', r, g, b)
end

---@param hex string|number
---@return { r: number, g: number, b: number }
local function hex_to_rgb(hex)
	if type(hex) == 'string' then
		if hex:byte(1) == 35 then -- #
			hex = hex:sub(2)
		end
	else
		hex = M.to_hex(hex)
	end
	return {
		r = tonumber(hex:sub(1, 2), 16),
		g = tonumber(hex:sub(3, 4), 16),
		b = tonumber(hex:sub(5, 6), 16),
	}
end

---Blends colors with an alpha value
---@param foreground string|number
---@param background string|number
---@param alpha number
---@return string?
M.blend = function(foreground, background, alpha)
	if not foreground or not background or not alpha then
		vim.notify('blend() returned nil', vim.log.levels.ERROR)
		return
	end

	foreground = type(foreground) == 'number' and M.to_hex(foreground) or foreground
	background = type(background) == 'number' and M.to_hex(background) or background
	local fg = hex_to_rgb(foreground)
	local bg = hex_to_rgb(background)

	-- Alpha blend formula: blended = alpha * fg + (1 - alpha) * bg
	local r = math.floor(alpha * fg.r + (1 - alpha) * bg.r + 0.5)
	local g = math.floor(alpha * fg.g + (1 - alpha) * bg.g + 0.5)
	local b = math.floor(alpha * fg.b + (1 - alpha) * bg.b + 0.5)

	-- Clamp values between 0 and 255
	r = math.max(0, math.min(255, r))
	g = math.max(0, math.min(255, g))
	b = math.max(0, math.min(255, b))
	return rgb_to_hex(r, g, b)
end

---@param name string
---@return boolean
function M.hl_exist(name)
	return not vim.tbl_isempty(M.get(name))
end

return M

---@alias utility.highlight.hl_list_fun fun():string, table

---@class utility.highlight.highlights
---@field basic table|table<string, table>|nil
---@field extra table|[string, table][]|utility.highlight.hl_list_fun[]|nil
---@field callback table|function[]|nil
