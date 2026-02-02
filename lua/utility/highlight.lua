local M = {}

M.vset_hl = vim.api.nvim_set_hl
M.vget_hl = vim.api.nvim_get_hl

M.hl_def_cache = {}
M.hl_link_cache = {}
M.apply_cache = {}

---Clear caches
function M.clear_cache()
	local function tbl_clear(t)
		for k, _ in pairs(t) do
			t[k] = nil
		end
	end

	tbl_clear(M.hl_def_cache)
	tbl_clear(M.hl_link_cache)
end

---This is the default table used to load highlights when M.apply() is called.
M.highlights = {}
---M.highlights_extra is used to load before M.highlights when M.apply() is called.
M.highlights_extra = {}

---Get the highlight but with the cache.
---Please use this function with M.set() to the best performance and no bug.
---@param name string Is the name of the highlight.
---@param cache boolean|nil Default is true
---@return table|vim.api.keyset.get_hl_info
function M.get(name, cache)
	cache = cache or true
	if cache then
		if not M.hl_link_cache[name] then
			M.hl_link_cache[name] = M.vget_hl(0, { name = name, link = false })
			return M.hl_link_cache[name]
		else
			return M.hl_link_cache[name]
		end
	end
	return M.vget_hl(0, { name = name, link = false })
end

---Like the vim.api.nvim_set_hl() but with the cache.
---Please use this function with M.get() to the best performance.
---@param name string Name of highlight.
---@param opts vim.api.keyset.highlight Options
---@param cache boolean|nil Default is true
function M.set(name, opts, cache)
	cache = cache or true
	if cache then
		if not M.hl_def_cache[name] then
			M.vset_hl(0, name, opts)
			M.hl_link_cache[name] = nil
			M.hl_def_cache[name] = true
		end
	else
		M.vset_hl(0, name, opts)
	end
end

---Modify highlight.
---@param name string The highlight name
---@param opts vim.api.keyset.highlight
---@param fallback boolean|nil If true the function will return a table.
---@return vim.api.keyset.highlight|nil|table
function M.modify(name, opts, fallback)
	local base = M.get(name) or {}
	local merged = vim.tbl_deep_extend("force", base, opts or {})

	if fallback then
		return merged
	else
		M.highlights[name] = merged
	end
end

---@param name string|table
---@param opts table|function|{ fn:function }
---@param apply boolean|nil
function M.work_if(name, opts, apply)
	if name == vim.g.colors_name then
		if type(opts) == "function" then
			M.highlights = vim.tbl_deep_extend("force", M.highlights, opts() or {})
		else
			if type(opts.callback) == "function" then
				opts = vim.tbl_deep_extend("force", M.highlights, opts.fn() or {})
			end
			M.highlights = vim.tbl_deep_extend("force", M.highlights, opts or {})
		end
		if apply then
			M.apply()
		end
	end
end

---Apply all highlights from M.highlights and other table.
---@param other table|function|nil
---@param cache boolean|nil
function M.apply(other, cache)
	M.clear_cache()
	cache = cache or true

	local function pair(t)
		if not t then
			return
		end
		if type(t) == "function" then
			t = t()
		end

		for name, opts in pairs(t) do
			if type(opts) == "function" then
				opts = opts()
			end

			if opts and type(opts) == "table" then
				M.set(name, opts, cache)
			end
		end
	end

	if other then
		pair(other)
	else
		pair(vim.tbl_extend("force", M.highlights, M.highlights_extra))
	end
end

---@alias hl_api.TextStyle
---|{
---  name:string,
---  type:"fg"|"bg"|nil,
---}
---|{
---  list:table,
---  key:string,
---  type:"fg"|"bg"|nil,
---}
---@alias hl_api.HlSpec
---|{
---  default_hl:string,
---  fg:hl_api.TextStyle|string|nil,
---  bg:hl_api.TextStyle|string|nil,
---  style:vim.api.keyset.highlight|nil,
---}

---Create your highlight!
---@param ns string Namespace
---@param spec hl_api.HlSpec Spection
---@return string
function M.mix_hl(ns, spec)
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
			return M.hl_link_cache[arg.list[arg.key] or arg.list[arg.default_key] or spec.default_hl][arg.type or fallback_key]
		end
		if type(arg) == "string" then
			return arg
		end
	end

	local function create_key(arg)
		if arg then
			if arg.list then
				return arg.list[arg.key] or ""
			end
		end
		return ""
	end

	spec.default_hl = spec.default_hl or "Normal"

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
