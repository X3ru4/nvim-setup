local function get(name)
	return vim.api.nvim_get_hl(0, { name = name })
end

local highlight = {
	WinBar = {
		fg = get("WarningMsg").fg,
		bg = get("Pmenu").bg,
		bold = true,
	},
	WinBarNC = {
		fg = get("WarningMsg").fg,
		bg = get("Pmenu").bg,
		bold = true,
	},
	Visual = {
		bg = "#112e80",
	},
}

-- apply highlight
for name, opts in pairs(highlight) do
	vim.api.nvim_set_hl(0, name, opts)
end
