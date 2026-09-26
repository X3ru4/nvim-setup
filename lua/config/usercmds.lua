local create_cmd = vim.api.nvim_create_user_command
local path = vim.fn.stdpath('config')

create_cmd('LoadHlConfig', function(opts)
	if opts.bang then
		require('utils.highlight').use_cache = false
	end
	vim.cmd.luafile(path .. '/lua/config/highlights.lua')
end, { bang = true })
