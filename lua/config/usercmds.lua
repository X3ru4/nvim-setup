local create_cmd = vim.api.nvim_create_user_command

create_cmd('LoadHlConfig', function()
	dofile(vim.fn.stdpath('config') .. '/lua/config/highlights.lua')
end, {})
