local M = {}

M.list = {}

function M.install(apply, list)
	list = list or M.list
	local t = {}
	local function push(spec)
		if spec[1] ~= apply[1] then
			t[#t + 1] = {
				spec[1],
				name = spec.name or nil,
				dependencies = spec.dependencies or nil,
				event = "VeryLazy",
			}
		end
	end

	for _, spec in ipairs(list) do
		push(spec)
	end
	t[#t + 1] = apply

	return t
end

return M
