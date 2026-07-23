local M = {}

---It is an iterator that runs Lua files in a directory.
---@param path string
---@param noreq boolean|nil
---@return function|nil
function M.load_file(path, noreq)
	path = vim.fs.joinpath(vim.fn.stdpath("config"), path)
	path = vim.fs.normalize(path)
  noreq = noreq or false
	local stat = vim.uv.fs_stat(path)
	assert(stat and stat.type == "directory", ("Invalid directory: %s"):format(path))

	local iter = vim.fs.dir(path)
	return function()
		while true do
			local name, kind = iter()
			if not name then
				return
			end

			if kind == "file" and name ~= "init.lua" and name:match("%.lua$") then
        if noreq then
          local file = vim.fs.joinpath(path, name)
          return name, dofile(file)
        else
          local module = vim.fs
            .joinpath(path, name)
            :gsub("^.*/lua/", "")
            :gsub("/init%.lua$", "")
            :gsub("%.lua$", "")
            :gsub("/", ".")

          return name, require(module)
        end
			end
		end
	end
end

---@param path string
function M.load_all(path)
	---@diagnostic disable-next-line: empty-block
	for _ in M.load_file(path) do
	end
end

---Like `require()`, but bypasses Lua's module cache.
---@param modname string
function M.reload(modname)
	package.loaded[modname] = nil
	return require(modname)
end

function M.is_plugin_loaded(name)
  local plugin = require("lazy.core.config").plugins[name]
  return plugin and plugin._.loaded ~= nil
end

return M
