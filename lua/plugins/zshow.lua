return {
	'sairyy/zshow.nvim',
	lazy = false, -- no need for lazy loading
	keys = {
		{ '<leader>z', '<Cmd>ZShow<Cr>' },
	},
	init = function()
		vim.g.zshow_opts = {
			winblend = 0, -- window pseudo-transparency
			width = 0.7, -- window width as a % of neovim's width
			height = 0.7, -- window height as a % of neovim's height

			-- dim windows behind zshow's window
			backdrop = {
				enable = false,
				-- only take effect if `enable` set to true
				winblend = 50, -- how much to dim by
				respect_transparent_bg = true, -- only dim if background isn't transparent
			},

			formatting = {
				listchars = { '●', '○' }, -- characters to use in listings based on nesting level
				show_version = true, -- display git commit SHA
				short_sha = true, -- use short commit SHA if `show_version = true`
			},

			-- same options as |nvim_open_win()|
			-- if win_config.{width,height} are supplied, they override the above
			-- `width` and `height` fields
			---@type vim.api.keyset.win_config
			win_config = {
				zindex = 50,
				title = ' Plugins ',
				title_pos = 'center',
			},
		}
	end,
}
