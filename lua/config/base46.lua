--- Simple base46 config
local M = {}
M._palette_cache = {}

-- Default options
M.options = {
	-- All availables theme at ~/.local/share/nvim/lazy/base46/lua/base46/hl_themes/
	theme = "onedark",
}

function M.load(opts)
	-- Exit if it can't be found
	local present, base46 = pcall(require, "base46")
	if not present then
		return
	end

	if opts then
		M.options = vim.tbl_extend("force", M.options, opts)
	end
	if not M._palette_cache[M.options.theme] then
		vim.g.base46_palette = base46.get_colors("base46", M.options.theme)
    M._palette_cache[M.options.theme] = true
	end
	vim.g.colors_name = "base46"
	base46.load_theme(M.options)
end

return M
