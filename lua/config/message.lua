local ui2 = require('vim._core.ui2')
local api = vim.api

ui2.cfg.msg.targets.default = 'msg'
ui2.cfg.msg.msg.height = 15

vim.keymap.set('n', 'mm', ui2.msg.msg_clear, { desc = 'Hide messages' })

local ns = api.nvim_create_namespace('MyMsgUI')
vim.ui_attach(ns, { ext_messages = true }, function(event)
	if event ~= 'msg_show' then
		return
	end
	vim.schedule(function()
		api.nvim_win_set_config(ui2.wins.msg, {
			border = { '', '', '', ' ', '', '', '', ' ' },
		})
		api.nvim_set_option_value('winhighlight', 'NormalFloat:StatusLine', { win = ui2.wins.msg })
	end)
end)

local echo_id
api.nvim_create_autocmd('LspProgress', {
	group = ui2.augroup,
	callback = function(ev)
		local value = ev.data.params.value

		if not value then
			return
		end

		local client = vim.lsp.get_client_by_id(ev.data.client_id).name
		local kind = value.kind
		local message = value.message
		local percent = value.percentage
		local status = 'running'
		local title = value.title

		if kind == 'begin' then
			message = 'Loading…'
		end

		if kind == 'end' then
			message = 'Done ✓'
			percent = 100
			status = 'success'
		end

		local chunks = {
			{ client, 'Function' }, -- { '<msg>', '<highlight>' }
			{ ': ' },
			{ title .. ' ' },
			{ percent .. '% ', 'Statement' },
			{ message, kind == 'end' and 'Added' or 'Changed' },
		}

		echo_id = api.nvim_echo(chunks, false, {
			id = echo_id,
			kind = 'progress',
			source = 'lsp-progress',
			status = status,
		})
	end,
})
