local M = {}
local hl = require("utility.highlight")

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
---  str:string|function,
---  hl:utility.highlight.advance_hl_spec|string|nil,
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
	if not spec.id then
		vim.notify("separator({ id = ? })")
    spec.id = "nil"
	end

	local function section_fmt(section, id)
		local sep_ns = "Separator" .. spec.id .. id
		if type(section) == "table" then
			section.hl.default_hl = spec.default_hl
			local hl_name = hl.advance_hl(sep_ns, section.hl)
			if type(section.str) == "function" then
				return section.str(hl_name)
			elseif type(section.str) == "string" then
				if type(section.hl) == "string" then
					return M.hl_fmt(section.hl, section.str)
				elseif not section.hl then
					return M.hl_fmt(spec.default_hl, section.str)
				end
				return M.hl_fmt(hl_name, section.str)
			end
		end
		return ""
	end

	return table.concat({
		section_fmt(spec.left, 1),
		section_fmt(spec.middle, 2),
		section_fmt(spec.right, 3),
		M.hl_fmt(spec.default_hl),
	})
end

return M
