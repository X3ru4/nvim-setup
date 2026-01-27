local create_cmd = vim.api.nvim_create_user_command

create_cmd("Reloadhl", function ()
  package.loaded["after.config.highlight"] = nil
  require("config.highlight").setup()
end, {})
