local M = {}

M.highlights = {}

---Get available highlight group info.
---@param name string Name of highlight group to get.
---@param link boolean|nil Whether to return the link target instead of resolved values.
---@return vim.api.keyset.highlight|nil hl_info Highlight information or nil if not found.
function M.get(name, link)
	if type(name) ~= "string" then
		vim.notify("[highlight_module] Invalid name (must be string)", vim.log.levels.ERROR)
	end
	return vim.api.nvim_get_hl(0, { name = name, link = link or false })
end

---Modify highlight info (merge existing + new opts).
---@param name string Highlight name.
---@param opts table Table of highlight options (fg, bg, bold, etc.).
---@param return_ boolean|nil If true, return merged table instead of applying.
---@return table|nil
function M.modify(name, opts, return_)
	local base = M.get(name) or {}
	local merged = vim.tbl_deep_extend("force", base, opts or {})

	if return_ then
		return merged
	else
		M.highlights[name] = merged
	end
end

---Apply highlight only if colorscheme matches.
---@param name string|string[] Colorscheme name(s) to match.
---@param opts table Highlight options.
---@param link table|nil Base highlight table to merge from.
---@return table opts
function M.work_if(name, opts, link)
	local current = vim.g.colors_name
	local matched = false

	if type(name) == "table" then
		for _, v in ipairs(name) do
			if v == current then
				matched = true
				break
			end
		end
	else
		matched = (current == name)
	end

	if matched then
		if link then
			opts = vim.tbl_deep_extend("force", link, opts)
		end
		if type(opts.callback) == "function" then
			opts.callback()
		end
		M.highlights = vim.tbl_deep_extend("force", M.highlights, opts)
	end

	return opts
end

---Apply all highlights stored in `M.highlights`.
function M.apply_highlight()
	for name, opts in pairs(M.highlights) do
		if type(name) ~= "string" then
			vim.notify(
				string.format("[highlight_module] Invalid highlight name: %s", vim.inspect(name)),
				vim.log.levels.ERROR
			)
		elseif type(opts) == "function" then
			opts = opts()
		end

		if opts and type(opts) == "table" then
			vim.api.nvim_set_hl(0, name, opts)
		end
	end
end

return M
