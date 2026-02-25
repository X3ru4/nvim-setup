local M = {}
local hl_api = require("utility.highlight")

M.separator_data = {}
M._fmt_cache = {}

---GamenhuCak
---@param hl_name string
---@param str string|nil
---@param last_str string|nil
---@return string
function M.hl_fmt(hl_name, str, last_str)
	str = str or ""
	last_str = last_str or ""
	return string.format("%%#%s#%s%s", hl_name, str, last_str)
end

---PADDING!
---@param s string
---@param l integer|nil
---@param r integer|nil
---@return string
function M.padding(s, l, r)
	return table.concat({
		string.rep(" ", l or 1),
		s or "",
		string.rep(" ", r or 1),
	})
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
		local hl_ns = table.concat({ "CustomHl", (spec.id or "nil"), id })

		local function value()
			if type(section.value) == "function" then
				return section.value(self)
			elseif type(section.value) == "string" then
				return section.value
			else
				return ""
			end
		end

		if type(section) == "table" then
			if type(section.hl) == "string" then
				return M.hl_fmt(section.hl) .. value()
			elseif section.hl == nil then
				return M.hl_fmt(spec.default_hl) .. value()
			end

			section.hl.default_hl = spec.default_hl
			self.hl = hl_api.mix_hl(hl_ns, section.hl)

			return M.hl_fmt(self.hl) .. value()
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
