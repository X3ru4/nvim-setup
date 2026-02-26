--- Simple base46 config
local M = {}
M._palette_cache = {}

-- Default options
M.options = {
	-- All availables theme at ~/.local/share/nvim/lazy/base46/lua/base46/hl_themes/
	theme = "onedark",
}

function M.load(opts, overwrite)
	overwrite = overwrite or true
	-- Exit if it can't be found
	local present, base46 = pcall(require, "base46")
	if not present then
		return
	end

	local opts_cache = {}
	if opts then
		if overwrite then
			M.options = vim.tbl_extend("force", M.options, opts)
		else
			opts_cache = M.options
			M.options = vim.tbl_extend("force", M.options, opts)
		end
	end
	if not M._palette_cache[M.options.theme] then
		vim.g.base46_palette = base46.get_colors("base46", M.options.theme)
		M._palette_cache[M.options.theme] = true
	end
	vim.g.colors_name = "base46-" .. M.options.theme
	base46.load_theme(M.options)
	if not overwrite then
		M.options = opts_cache
	end
end

return M
