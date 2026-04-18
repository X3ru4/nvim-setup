local M = {}
local colorscheme = require("config.colorscheme")

---Creates a colorscheme spec for lazy.nvim
---@param apply string Name of the colorscheme to apply
---@param queue table<string> A list of colorscheme names to load before the applied one. This is useful to have a fallback in case the applied colorscheme fails to load.
---@return table
function M.create_spec(apply, queue)
	queue = queue or {}
	local t = {}

	for _, name in ipairs(queue) do
		local spec = colorscheme[name]
    if spec then
      if name ~= apply then
        t[#t + 1] = {
          spec[1],
          name = name,
          dependencies = spec.dependencies or nil,
          event = "VeryLazy",
        }
      end
    end
	end

	if colorscheme[apply] then
		t[#t + 1] = colorscheme[apply]
	end

	return t
end

return M
