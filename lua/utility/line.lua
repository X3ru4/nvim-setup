local M = {}
local hl_api = require("utility.highlight")

M.__hl_fmt_cache = {}
M.__pad_cache = {}

---GamenhuCak
---@param hl_name string
---@param str string|nil
---@param last_str string|nil
---@return string
function M.hl_fmt(hl_name, str, last_str)
	hl_name = hl_name or ""
	str = str or ""
	last_str = last_str or ""
	local field = hl_name .. str .. last_str
	if not M.__hl_fmt_cache[field] then
		M.__hl_fmt_cache[field] = string.format("%%#%s#%s%s", hl_name, str, last_str)
	end
	return M.__hl_fmt_cache[field]
end

---PADDING!
---@param s string
---@param l integer|nil
---@param r integer|nil
---@return string
function M.padding(s, l, r)
	s = s or ""
	l = l or 1
	r = r or 1
  local field = s .. l .. r
  if not field then
    M.__pad_cache[field] = string.rep(" ", l) .. s .. string.rep(" ", r)
  else
    return M.__pad_cache[field]
  end
  return ""
end

---@alias line.SepPart
---|{
---  value:string|function,
---  hl:hl_api.HlSpec|string|nil,
---}

---Overpower!
---@param spec
---|{
---  id:string,
---  default_hl:string,
---  left:line.SepPart,
---  right:line.SepPart,
---  string:line.SepPart,
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
		section_fmt(spec.left, "0"),
		section_fmt(spec.string, "1"),
		section_fmt(spec.right, "2"),
		M.hl_fmt(spec.default_hl),
	})
end

return M
