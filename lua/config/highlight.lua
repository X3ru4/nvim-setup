local function get(name)
	return vim.api.nvim_get_hl(0, { name = name })
end

local highlights = {
	-- WinBar = function()
	-- 	return { link = "StatusLine" }
	-- end,
	-- WinBarNc = function()
	-- 	return { link = "StatusLineNC" }
	-- end,

	-- Other

	-- MiniTablineCurrent = {
	-- 	link = "TabLineSel",
	-- },
}

-- apply highlight
for name, opts in pairs(highlights) do
	if type(opts) == "function" then
		opts = opts()
	end
	if opts ~= nil then
		vim.api.nvim_set_hl(0, name, opts)
	end
end
