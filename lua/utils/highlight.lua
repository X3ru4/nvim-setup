---@alias utility.highlight.hl_list_fun fun():string, vim.api.keyset.highlight
---@alias utility.highlight.highlights [string, vim.api.keyset.highlight]|[string, vim.api.keyset.highlight][]|utility.highlight.hl_list_fun[]

local M = {}
local api = vim.api
M.variables = {}
---This is the default table used to load highlights when M.apply() is called.
M.data = {
	[1] = {},
	---@type [string, function]
	__callbacks = {},
}

function M.get(name)
	return api.nvim_get_hl(0, { name = name, link = false })
end

function M.getfg(name)
	return api.nvim_get_hl(0, { name = name, link = false }).fg
end

function M.getbg(name)
	return api.nvim_get_hl(0, { name = name, link = false }).bg
end

function M.set(name, opts)
	api.nvim_set_hl(0, name, opts)
end

---@param name string
---@param fallback string?
---@return string|number|nil
function M.get_var(name, fallback)
	if M.variables[name] then
		return M.variables[name]
	else
		if fallback then
			local hl = vim.split(fallback, ' ', { plain = true })
			return M.get(hl[1])[hl[2]]
		end
	end
end

function M.set_var(name, value, default)
	if default and M.variables[name] then
		return
	end
	M.variables[name] = value
end

---@param hl_list utility.highlight.highlights
function M.insert(hl_list)
	M.data[1] = vim.tbl_deep_extend('force', M.data[1], hl_list)
	return M.data[1]
end

---@param name string
---@param opts vim.api.keyset.highlight
---@return [string, table]
function M.modify(name, opts)
	if not M.hl_exist(name) then
		return {}
	end
	return { name, vim.tbl_extend('force', M.get(name), opts) }
end

---Apply highlights from `hl_list`. If `hl_list` is empty (nil), apply the M.data[1] table instead.
---@param hl_list nil|utility.highlight.highlights
function M.apply(hl_list)
	local data = (hl_list and hl_list ~= {}) and hl_list or M.data[1]
	if data and data ~= {} then
		for name, opts in pairs(data) do
			if type(name) == 'number' then
				if type(opts) == 'function' then
					local hl, hl_opts = opts()
					api.nvim_set_hl(0, hl, hl_opts)
				else
					if opts[1] and opts[2] then
						api.nvim_set_hl(0, opts[1], opts[2])
					end
				end
			else
				api.nvim_set_hl(0, name --[[@as string]], opts --[[@as vim.api.keyset.highlight]])
			end
		end
	end
end

---This function use to callback your function when highlight is load or reload.
---@param callback function
---@param call boolean?
function M.add_hook(callback, call)
	if call then
		callback()
	end
	table.insert(M.data.__callbacks, callback)
end

function M.run_hooks()
	if next(M.data.__callbacks) then
		for _, callback in ipairs(M.data.__callbacks) do
			callback()
		end
	end
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
		vim.notify('M.blend(): Color blending failed', vim.log.levels.ERROR)
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
	return next(M.get(name)) ~= nil
end

return M
