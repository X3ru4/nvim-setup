local M = {}

M = {
  --Setup highlight here.
	highlights = {},

  ---Get available highlight.
  ---@param name string Name of highlight to get
  ---@return vim.api.keyset.get_hl_info
	get = function(name)
		return vim.api.nvim_get_hl(0, { name = name })
	end,

	---Simple code
	---@param name string|table of colorscheme
	---@param opts table Highlight
	---@param link table|nil Use base opts to set
	---@return any
	workIf = function(name, opts, link)
		local current_color = vim.g.colors_name
		local matched = false

		if type(name) == "table" then
			for i = 1, #name do
				if current_color == name[i] then
					matched = true
					break
				end
			end
		else
			matched = (current_color == name)
		end

		if matched then
			if link ~= nil then
				opts = vim.tbl_deep_extend("force", link, opts)
			end
			M.highlights = vim.tbl_deep_extend("force", M.highlights, opts)
		end

		return opts
	end,

  ---Set all highlight in M.highlight table.
	aplly_highlight = function()
		for name, opts in pairs(M.highlights) do
			if type(opts) == "function" then
				opts = opts()
			end
			vim.api.nvim_set_hl(0, name, opts)
		end
	end,
}

return M
