return {
	'nvim-mini/mini.notify',
	version = false,
	event = 'UIEnter',
	keys = {
		{
			'<C-h>',
			function()
				require('mini.notify').show_history()
			end,
		},
	},
	config = function()
		local notify_msg = ''
		require('mini.notify').setup({
			-- Content management
			content = {
				format = function(notif)
					if notif.data.source == 'lsp_progress' then
						return notif.msg
					end
					notify_msg = notif.msg
					return string.format('%s: %s', notif.level, notif.msg)
				end,
			},

			-- Notifications about LSP progress
			lsp_progress = { enable = true },

			-- Window options
			window = {
				-- Floating window config
				---@type vim.api.keyset.win_config|function
				config = function()
					return {
						border = nil,
						title = '› Notifications ‹',
						title_pos = 'center',
						width = (notify_msg:len() < 17 and 17) or nil,
					}
				end,

				-- Maximum window width as share (between 0 and 1) of available columns
				max_width_share = 0.382,
				winblend = vim.o.winblend,
			},
		})

		-- Hook neovim messages to `vim.notify`.
		local ui2 = require('vim._core.ui2')
		local ns = vim.api.nvim_create_namespace('MyUI2')

		-- Use the 'msg' target.
		ui2.cfg.msg.target = 'msg'
		-- HACK: Hide the default message UI.
		ui2.cfg.msg.msg.height = 0.01
		ui2.cfg.msg.msg.timeout = 0.0

		local levels = {
			emsg = vim.log.levels.ERROR, -- Error message
			comfirm = vim.log.levels.TRACE, -- Comfirm message
		}
		local skip_kind = {
			search_cmd = true,
			search_count = true,
		}

		local function suitable_kind(msg)
			return msg:find('^.-(E)') and 'emsg' or kind
		end

		vim.ui_attach(ns, { ext_messages = true }, function(event, ...)
			if event == 'msg_show' then
				local kind, content = ...
				if not content[1] or skip_kind[kind] then
					return 0
				end
				if #content > 1 then
					for _, c in ipairs(content) do
						kind = suitable_kind(c[2])
						vim.notify(c[2], levels[kind])
					end
				else
					kind = suitable_kind(content[1][2])
					vim.notify(content[1][2], levels[kind])
				end
				return 0
			end
		end)
	end,
}
