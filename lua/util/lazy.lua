local M = {}

function M.is_loaded(name)
  return require("lazy.core.config").plugins[name]._.loaded
end

return M
