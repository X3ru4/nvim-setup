local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })
local hl = require('utils.highlight')

-- Highlight on yank.
autocmd('TextYankPost', {
	group = group,
	callback = function()
		vim.hl.on_yank({ higroup = 'Yank', timeout = 150 })
	end,
})
autocmd({ 'InsertLeave', 'WinEnter' }, {
	group = group,
	callback = function()
		vim.o.cursorline = true
	end,
})
autocmd({ 'InsertEnter', 'WinLeave' }, {
	group = group,
	callback = function()
		vim.o.cursorline = false
	end,
})

-- Load highlight configuration when changing colorscheme.
autocmd('ColorScheme', {
	group = group,
	callback = function()
		vim.cmd.LoadHlConfig({ bang = true })
	end,
})
-- Setup highlights
autocmd('UIEnter', {
	group = group,
	once = true,
	callback = function()
		vim.cmd.LoadHlConfig()
	end,
})
-- LSP
autocmd('User', {
	group = group,
	pattern = 'VeryLazy',
	once = true,
	callback = function()
		require('config.lsp').setup()
	end,
})
autocmd('LspAttach', {
	group = group,
	callback = function(ev)
		require('config.lsp').attach(ev)
	end,
})

local usercmd = vim.api.nvim_create_user_command
local conf_path = vim.fn.stdpath('config')

usercmd('LoadHlConfig', function(opts)
	if opts.bang then
		hl.use_cache = false
	end
	vim.cmd.luafile(conf_path .. '/lua/config/highlights.lua')
end, { bang = true, desc = 'Load hightlighs config' })

usercmd('GenTermuxColor', function(opts)
	if not opts.bang and not vim.env.TERMUX_VERSION then
		vim.notify('This command is for Termux only; please use `!` at the end of the command to skip.')
		return
	end

	local filename = vim.fs.abspath('~/.termux/colors.properties')
	local base16 = 'color%d=%s' -- base16 colors format
	local key = '%s=%s' -- keys format
	local lines = { '# These colors are created using Colorscheme Neovim: ' .. vim.g.colors_name }

	for i = 0, 15 do
		local color = vim.g['terminal_color_' .. i]

		if color then
			lines[#lines + 1] = base16:format(i, color)
		end
	end

	local keys = {
		foreground = hl.to_hex(hl.getfg('Normal')),
		background = hl.to_hex(hl.getbg('Normal')),
		cursor = hl.to_hex(hl.getbg('Cursor')),
	}

	vim.iter(keys):each(function(k, v)
		lines[#lines + 1] = key:format(k, v)
	end)

	local file = io.open(filename, 'w')
	if file then
		file:write(table.concat(lines, '\n'))
		file:close()
		vim.system({ 'termux-reload-settings' }, { text = true }, function(out)
			if out.code ~= 0 then
				vim.notify(out.stderr)
			end
		end)
	else
		vim.notify('Open ' .. filename .. ' failed!', vim.log.levels.ERROR)
	end
end, { bang = true, desc = 'Transferring Neovim terminal color scheme to Termux' })
