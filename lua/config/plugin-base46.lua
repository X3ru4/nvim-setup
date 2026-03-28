--- Simple base46 config
local M = {}
M.__palette_cache = {}

-- Default options
M.options = {
	-- All availables theme at ~/.local/share/nvim/lazy/base46/lua/base46/hl_themes/
	theme = "onedark", -- default theme
}

---@param opts table|nil
function M.load(opts)
	-- Exit if it can't be found
	local present, base46 = pcall(require, "base46")
	if not present then
		return
	end

	local theme = M.options.theme

	if opts then
		opts.theme = opts.theme or theme
		M.options = vim.tbl_extend("force", M.options, opts)
	end
	if not M.__palette_cache[theme] then
		M.__palette_cache[theme] = base46.get_colors("base46", theme)
		vim.g.base46_palette = M.__palette_cache[theme]
	else
		vim.g.base46_palette = M.__palette_cache[theme]
	end
	vim.g.colors_name = "base46-" .. theme
	base46.load_theme(M.options)
end

return M
