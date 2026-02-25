-- exit if it can't be found
local present, base46 = pcall(require, "base46")
if not present then
	return
end

-- Press gf to go the folder
-- All availables theme at ~/.local/share/nvim/lazy/base46/lua/base46/hl_themes/
local theme = "onedark"
local color_base = "base46"
local theme_opts = {
	base = color_base,
	theme = theme,
	transparency = false, -- Unrecomment at now
}
local palette = base46.get_colors(color_base, theme)
vim.g.base46_palette = palette

base46.load_theme(theme_opts)
