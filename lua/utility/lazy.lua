local M = {}

function M.plugin_loaded(name)
  local ok, cfg = pcall(require, "lazy.core.config")
  if not ok or not cfg.plugins then
    return false
  end
  return cfg.plugins[name] ~= nil
end

return M
