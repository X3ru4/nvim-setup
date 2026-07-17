local M = {}
local cs_list = {}

M.default = "default"

local function load_colorscheme()
	local ok, err = pcall(function()
		for _, spec in require("utility.loader").load_file("lua/plugins/colorscheme", true) do
			cs_list[#cs_list + 1] = spec
		end
	end)

	if not ok then
		error(err)
	end
end

function M.create_spec()
	load_colorscheme()
	if cs_list == {} then
		return {}
	end
	local t = {}

	for _, spec in ipairs(cs_list) do
		if spec.name == M.default or spec[1] == M.default then
			t[#t + 1] = spec
		else
			t[#t + 1] = {
				spec[1],
				name = spec.name or nil,
				dependencies = spec.dependencies or nil,
				event = "VeryLazy",
			}
		end
	end

	return t
end

return M
