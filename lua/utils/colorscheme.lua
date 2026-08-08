local M = {}
local loader = require('utils.loader')
M.themes = {}

M.default = 'default'
M.variant = 'default'
M.install = {}

local function load_colorscheme()
	local listed, is_default = true, true
	for _, spec in loader.load_file('lua/plugins/colorscheme') do
		if spec then
			if M.install[1] ~= '*' then
				listed = M.install[spec.name or spec[1] or spec.url or spec.dir]
				is_default = (spec.name or spec[1] or spec.url or spec.dir) == M.default
			end

			if listed or is_default then
				M.themes[#M.themes + 1] = spec
			end
		end
	end
end

function M.create_spec()
	load_colorscheme()
	if M.themes == {} then
		return {}
	end
	local t = {}

	for _, spec in ipairs(M.themes) do
		if spec.name == M.default or spec[1] == M.default then
			t[#t + 1] = spec
		else
			if spec and spec ~= {} then
				t[#t + 1] = {
					spec[1],
					name = spec.name or nil,
					event = 'VeryLazy',
					dependencies = spec.dependencies or nil,
				}
			end
		end
	end

	return t
end

return M
