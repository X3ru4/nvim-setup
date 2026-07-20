local M = {}

M.del = vim.keymap.del
M.set = vim.keymap.set

---@param list vim.keymap.set.Opts[]
function M.set_list(list)
	for _, opts in ipairs(list) do
		local ok, _ = pcall(M.set, unpack(opts))
		if not ok then
			vim.notify("Invalid keymap\n" .. vim.inspect(opts), vim.log.levels.WARN)
		end
	end
end

---@param list vim.keymap.set.Opts[]
function M.del_list(list)
  for _, opts in ipairs(list) do
    local ok, _ = pcall(M.del, unpack(opts))
    if not ok then
      vim.notify("Cannot delete keymap\n" .. vim.inspect(opts), vim.log.levels.WARN)
    end
  end
end

return M
