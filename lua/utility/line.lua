local M = {}
local hl_api = require("utility.highlight")

local cache = {
  space = {},
  hl_fmt = {},
}

---Convert the highlight name to the string can use at statusline,..
---@param hl_name string
---@param str string|nil
---@param last_str string|nil
---@return string
function M.hl_fmt(hl_name, str, last_str)
	hl_name = hl_name or ""
	str = str or ""
	last_str = last_str or ""
	local field = hl_name .. str .. last_str
	if cache.hl_fmt[field] then
		return cache.hl_fmt[field]
	end

	local result = string.format("%%#%s#%s%s", hl_name, str, last_str)
	cache.hl_fmt[field] = result
	return result
end

local function get_space(n)
	if cache.space[n] then
		return cache.space[n]
	end

	local result = string.rep(" ", n)
	cache.space[n] = result
	return result
end

---Simple string padding function
---@param s string
---@param l integer|nil
---@param r integer|nil
---@return string
function M.padding(s, l, r)
	s = s or ""
	l = l or 1
	r = r or 1
	return get_space(l) .. s .. get_space(r)
end

---@alias line.SepPart
---|{
---  value:string|function,
---  hl:hl_api.HlSpec|string|nil,
---}

---This function can create your beautiful line
---@param spec
---|{
---  id:string,
---  default_hl:string,
---  left:line.SepPart,
---  right:line.SepPart,
---  middle:line.SepPart,
---}
---@return string
function M.separator(spec)
	local self = {}

	if not spec.id then
		vim.notify("separator({ id = ? })")
	end

	local function section_fmt(section, id)
		local hl_ns = "CustomHl" .. (spec.id or "nil") .. id
		if type(section) == "table" then
			section.hl.default_hl = spec.default_hl
			self.hl = hl_api.mix_hl(hl_ns, section.hl) -- Create new the highlight group for this section
			if type(section.value) == "function" then
				return section.value(self)
			elseif type(section.value) == "string" then
				if type(section.hl) == "string" then
					return M.hl_fmt(section.hl, section.value)
				elseif not section.hl then
					return M.hl_fmt(spec.default_hl, section.value)
				end
				return M.hl_fmt(self.hl, section.value)
			end
		end
		return ""
	end

	return table.concat({
		section_fmt(spec.left, 0),
		section_fmt(spec.middle, 1),
		section_fmt(spec.right, 2),
		M.hl_fmt(spec.default_hl),
	})
end

return M
