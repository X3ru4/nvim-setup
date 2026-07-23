local M = {}
M.list = {}

M.default = "default"

local function load_colorscheme()
	local ok, err = pcall(function()
		for _, spec in vimu.loader.load_file("lua/plugins/colorscheme") do
			M.list[#M.list + 1] = spec
		end
	end)

	if not ok then
		error(err)
	end
end

function M.create_spec()
	load_colorscheme()
	if M.list == {} then
		return {}
	end
	local t = {}

	for _, spec in ipairs(M.list) do
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
