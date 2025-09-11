local function get(name)
	return vim.api.nvim_get_hl(0, { name = name })
end

local highlight = {
	WinBar = {
		fg = get("StatusLine").fg,
		bg = get("StatusLineNC").bg,
	},
	WinBarNC = {
		fg = get("StatusLine").fg,
		bg = get("StatusLineNC").bg,
	},
}

-- apply highlight
for name, opts in pairs(highlight) do
	vim.api.nvim_set_hl(0, name, opts)
end
