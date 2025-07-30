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
})
