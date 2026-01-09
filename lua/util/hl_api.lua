local M = {}

M.vset_hl = vim.api.nvim_set_hl
M.vget_hl = vim.api.nvim_get_hl

M.hl_def_cache = {}
M.hl_link_cache = {}

local function tbl_clear(t)
	for k, _ in pairs(t) do
		t[k] = nil
	end
end

function M.clear_cache()
	tbl_clear(M.hl_def_cache)
	tbl_clear(M.hl_link_cache)
end

M.highlights = {}

---Get the highlight but with the cache.
---Please use this function with M.set() to the best performance and no bug.
---@param name string Is the name of the highlight.
---@return vim.api.keyset.highlight
function M.get(name)
	if not M.hl_link_cache[name] then
		M.hl_link_cache[name] = M.vget_hl(0, { name = name, link = false })
		return M.hl_link_cache[name]
	end
	return M.hl_link_cache[name]
end

---Like vim.api.nvim_set_hl() but with the cache.
---Please use this function with M.get() to the best performance.
---@param name string The name of highlight.
---@param opts vim.api.keyset.highlight Options
function M.set(name, opts)
	if not M.hl_def_cache[name] then
		M.vset_hl(0, name, opts)
		M.hl_link_cache[name] = nil
		M.hl_def_cache[name] = true
	end
end

---Modify highlight.
---@param name string Highlight name
---@param opts table Highlight options
---@param return_ boolean|nil If true the function will return a table.
---@return vim.api.keyset.highlight|nil
function M.modify(name, opts, return_)
	local base = M.get(name) or {}
	local merged = vim.tbl_deep_extend("force", base, opts or {})

	if return_ then
		return merged
	else
		M.highlights[name] = merged
	end
end

function M.work_if(name, opts)
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = name,
		callback = function()
			if type(opts.callback) == "function" then
				opts.callback()
			end
			M.highlights = vim.tbl_deep_extend("force", M.highlights, opts or {})
		end,
	})
end

---Apply all the highlights in M.highlights
function M.apply()
	for name, opts in pairs(M.highlights) do
		if type(opts) == "function" then
			opts = opts()
		end

		if opts and type(opts) == "table" then
			M.set(name, opts)
		end
	end
end

---A powerful function.
---Ex: M.mix_hl("Statusline", {
---   default_hl = nil|string,
---   Here is a simple foreground.
---  fg = {
---    name = "WinBar",
---    type = "fg"|"bg"|nil Default is "fg"
---  },
---  or
---  fg = {
---    list = {
---      key = "Highlight name",
---      other = "Other highlight name",
---      any_name = "Pmenu"
---    },
---    -- Field fg.use is the name of the key in fg.list.
---    use = "key"|"other"
---  },
---  or fg can be a string with the value is the name of highlight and nil.
---  bg = smillar fg,
---  style = vim.api.keyset.highlight|nil
---})
---@param ns string Namespace
---@param spec table Spection
---@return string
function M.mix_hl(ns, spec)
	spec.default_hl = spec.default_hl or "Normal"
	local function pick_hl(arg, fallback_key)
		if arg == nil then
			return M.get(spec.default_hl)[fallback_key]
		end
		if arg.name then
			return M.get(arg.name)[arg.type or fallback_key]
		end
		if arg.list then
			for _, v in pairs(arg.list) do
				M.get(v)
			end
			return M.hl_link_cache[arg.list[arg.use] or spec.default_hl][arg.type or fallback_key]
		end
		if type(arg) == "string" then
			return M.get(arg)[fallback_key]
		end
	end
	local function create_key(arg)
		if arg then
			if arg.list then
				return arg.list[arg.use] or ""
			end
		end
		return ""
	end
	ns = table.concat({
		ns,
		create_key(spec.fg),
		create_key(spec.bg),
	})
	M.set(
		ns,
		vim.tbl_extend("keep", {
			fg = pick_hl(spec.fg, "fg"),
			bg = pick_hl(spec.bg, "bg"),
		}, spec.style or {})
	)
	return ns
end

return M
