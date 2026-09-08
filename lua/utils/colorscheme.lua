---This util manages colorschemes.

local M = {}
M.themes = {}

M.default = 'default'
M.variant = 'default'
M.install = {}

local function load_colorscheme()
	for _, name in ipairs(M.install) do
		local module = 'plugins.themes.' .. name
		local is_module, spec = pcall(require, module)
		if is_module then
			if spec then
				M.themes[#M.themes + 1] = spec
			end
		else
			vim.notify('Module cannot be executed: ' .. module)
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
			spec.lazy = false
			spec.priority = 1000
			t[#t + 1] = spec
		else
			if spec and spec ~= {} then
				t[#t + 1] = {
					spec[1] or spec.url or spec.dir,
					name = spec.name,
					event = 'VeryLazy',
					dependencies = spec.dependencies,
				}
			end
		end
	end

	return t
end

return M
