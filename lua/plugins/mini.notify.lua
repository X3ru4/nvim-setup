return {
	'nvim-mini/mini.notify',
	event = 'UIEnter',
	version = false,
	keys = {
		{
			'<C-h>',
			function()
				require('mini.notify').show_history()
			end,
		},
	},
	config = function()
		local MiniNotify = require('mini.notify')

		MiniNotify.setup({
			-- Content management
			content = {
				format = function(notif)
					if notif.data.source == 'lsp_progress' then
						return notif.msg
					end
					return notif.level .. ': ' .. notif.msg
				end,
			},

			-- Notifications about LSP progress
			lsp_progress = { enable = true },

			-- Window options
			window = {
				-- Floating window config
				config = {
					border = nil,
					title = ' Notifications ',
					title_pos = 'right',
				},

				-- Maximum window width as share (between 0 and 1) of available columns
				max_width_share = 0.382,
				winblend = vim.o.winblend,
			},
		})

		vim.notify = MiniNotify.make_notify({
			ERROR = { duration = 4000 },
			WARN = { duration = 3000 },
			INFO = { duration = 2000 },
		})

		-- Hook Neovim messages to `vim.notify`.
		local ui2 = require('vim._core.ui2')
		local ns = vim.api.nvim_create_namespace('MyUI2')

		-- Use the 'msg' target.
		ui2.cfg.msg.target = 'msg'
		-- HACK: Hide the default message UI.
		ui2.cfg.msg.msg.height = 0.01
		ui2.cfg.msg.msg.timeout = 0

		local levels = vim.log.levels
		local handlers = {
			emsg = levels.ERROR, -- Error message
			echoerr = levels.ERROR,
			lua_error = levels.ERROR,
			comfirm = levels.WARN, -- Comfirm message
		}
		local exclude_kind = {
			search_cmd = true,
			search_count = true,
		}

		vim.ui_attach(ns, { ext_messages = true }, function(event, ...)
			if event == 'msg_show' then
				local kind, content = ...

				if not content[1] or exclude_kind[kind] then
					return
				end

				if #content > 1 then
					for i = 1, #content do
						local chunk = content[i]
						vim.notify(chunk[2], handlers[kind])
					end
					return 0
				end

				vim.notify(content[1][2], handlers[kind])
				return 0
			end
		end)
	end,
}
