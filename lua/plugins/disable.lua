local function disable(plugin)
  local M = {}
  for _, value in ipairs(plugin) do
    table.insert(M, {
      enabled = false,
      value,
    })
  end
  return M
end

return disable({
  "flash.nvim",
  "grug-far.nvim",
  "trouble.nvim",
  "todo-comments.nvim",
})
-- 2025-08-01 08:32
