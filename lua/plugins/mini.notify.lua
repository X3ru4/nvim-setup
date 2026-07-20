return {
	"nvim-mini/mini.notify",
	lazy = false,
	version = false,
	keys = {
		{
			"<C-h>",
			function()
				require("mini.notify").show_history()
			end,
		},
	},
	config = function()
		local notify = {}
		require("mini.notify").setup({
			-- Content management
			content = {
				format = function(notif)
					notify = notif
					if notif.data.source == "lsp_progress" then
						return notif.msg
					end
					return string.format("%s: %s", notif.level, notif.msg)
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
						border = "rounded",
						title = "› Notifications ‹",
						title_pos = "center",
						width = (notify.msg:len() < 17 and 17) or nil,
					}
				end,

				-- Maximum window width as share (between 0 and 1) of available columns
				max_width_share = 0.5,
				winblend = 0,
			},
		})

		-- Hook neovim messages to `vim.notify`.
		local ui2 = require("vim._core.ui2")
		local ns = vim.api.nvim_create_namespace("MyUI2")

		-- Use the 'msg' target.
		ui2.cfg.msg.target = "msg"
		-- HACK: Hide the default message UI.
		ui2.cfg.msg.msg.timeout = 0

		local levels = {
			emsg = vim.log.levels.ERROR, -- Error message
			comfirm = vim.log.levels.INFO, -- Comfirm message
		}

		vim.ui_attach(ns, { ext_messages = true }, function(event, ...)
			if event == "msg_show" then
				local kind, content = ...
				if not content[1] then
					return
				end
				vim.notify(content[1][2], levels[kind] or nil)
				return true
			end
		end)
	end,
}
