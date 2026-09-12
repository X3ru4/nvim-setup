local cache = {
	def = {},
	get = {},
}

local M = {}

M.alias = {}
M.use_cache = true

---This is the default table used to load highlights when M.apply() is called.
M.highlight = {
	basic = {},
	extra = {},
	callback = {},
}

function M.clear_cache()
	cache.def = {}
	cache.get = {}
end

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

function M.get_color(alias)
	if M.alias[alias] then
		return M.alias[alias]
	end
	vim.notify(alias .. ' alias not found!', vim.log.levels.ERROR)
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

	if append then
		M.highlight.basic[name] = opts
	end

	return { name, opts }
end

---Apply highlights from `hl_list`. If `hl_list` is empty (nil), apply the M.highlights table instead.
---@param hl_list nil|utility.highlight.highlights
---@param no_cache boolean|nil
function M.apply(hl_list, no_cache)
	local t = (hl_list and hl_list ~= {}) and hl_list or M.highlight
	if t then
		if t.basic and t.basic ~= {} then
			for name, opts in pairs(t.basic) do
				if no_cache then
					cache.def[name] = nil
				end
				M.set(name, opts)
			end
		end
		if t.extra and t.extra ~= {} then
			for _, val in ipairs(t.extra) do
				if type(val) == 'function' then
					local name, opts = val()
					if no_cache then
						cache.def[name] = nil
					end
					M.set(name, opts)
				else
					if val[1] and val[2] then
						if no_cache then
							cache.def[val[1]] = nil
						end
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
---@param init boolean|nil
---@param condition function|boolean|nil
function M.add_hook(id, callback, init, condition, on_color)
	local cond = type(condition) == 'function' and condition() or condition
	if (cond == nil and true or cond) and M.highlight.callback[id] then
		M.highlight.callback[id]()
		return
	end
	if init then
		callback()
		if on_color then
			M.highlight.callback[id] = { callback }
			return
		end
	end
	M.highlight.callback[id] = callback
end

local started = false

function M.run_hooks()
	if M.highlight.callback and M.highlight.callback ~= {} then
		for _, data in pairs(M.highlight.callback) do
			if type(data) == 'function' then
				data()
			elseif type(data) == 'table' then
				if started then
					data[1]()
				end
			end
		end
	end
end

---Setup
---@param config function
function M.setup(config)
	if started then
		M.highlight.basic = {}
		M.highlight.extra = {}
	end

	if not M.use_cache then
		M.clear_cache()
	end

	config()
	M.apply()
	M.run_hooks()
	M.use_cache, started = true, true
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

local function rgb_to_hex(r, g, b)
	return string.format('#%02x%02x%02x', r, g, b)
end

function M.dec_to_hex(dec_color)
	if type(dec_color) == 'number' then
		return string.format('#%06X', dec_color)
	end
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
