local create_cmd = vim.api.nvim_create_user_command
local path = vim.fn.stdpath('config')

create_cmd('LoadHlConfig', function()
	vim.cmd.luafile(path .. '/lua/config/highlights.lua')
end, {})
