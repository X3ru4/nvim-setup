---This util manages colorschemes.

local M = {}

M.install = {}
M.installed_themes = {}
M.default = 'default'
M.variant = nil

local function read_modules()
	for _, name in ipairs(M.install) do
		local module = 'plugins.themes.' .. name
		local is_module, spec = pcall(require, module)
		if is_module then
			if spec then
				spec.module_name = name
				table.insert(M.installed_themes, spec)
			end
		else
			vim.notify('Module cannot be executed: ' .. module)
		end
	end
end

local function is_default(spec)
	return spec.name == M.default or spec.module_name == M.default or spec[1] == M.default or spec.url == M.default
end

function M.create_spec()
	read_modules()
	if next(M.installed_themes) == nil then
		return {}
	end
	local specs = {}

	for _, spec in ipairs(M.installed_themes) do
		if spec[1] or spec.url then
			if is_default(spec) then
				spec.lazy = false
				spec.priority = 1000
			else
				spec.lazy = true
			end
			specs[#specs + 1] = spec
		end
	end

	return specs
end

return M
