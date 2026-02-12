local create_cmd = vim.api.nvim_create_user_command

-- Setup highlighting configuration
create_cmd("SetupHl", function()
	package.loaded["config.highlight"] = nil
	require("config.highlight").setup()
end, {})
