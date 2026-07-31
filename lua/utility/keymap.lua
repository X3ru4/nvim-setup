local M = {}

M.del = vim.keymap.del
M.set = vim.keymap.set

---@alias utility.keymap.mode "n"|"i"|"v"|"x"|"s"|"c"|"o"|"t"|"!"

---@param list [utility.keymap.mode|utility.keymap.mode[], string, string|function, vim.keymap.set.Opts][]
function M.set_list(list)
	for _, opts in ipairs(list) do
		local ok, err = pcall(M.set, unpack(opts))
		if not ok then
			vim.notify(err .. "\n" .. vim.inspect(opts), vim.log.levels.WARN)
		end
	end
end

---@param list [utility.keymap.mode|utility.keymap.mode[], string, vim.keymap.del.Opts][]
function M.del_list(list)
	for _, opts in ipairs(list) do
		local ok, err = pcall(M.del, unpack(opts))
		if not ok then
			vim.notify(err .. "\n" .. vim.inspect(opts), vim.log.levels.WARN)
		end
	end
end

return M
