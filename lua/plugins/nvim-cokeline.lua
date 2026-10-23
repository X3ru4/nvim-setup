return {
	'willothy/nvim-cokeline',
	event = 'BufReadPre',
	config = function()
		local is_picking_focus = require('cokeline.mappings').is_picking_focus
		local is_picking_close = require('cokeline.mappings').is_picking_close
		local get_hex = require('cokeline.hlgroups').get_hl_attr
		local red = vim.g.terminal_color_1
		local yellow = vim.g.terminal_color_3

		vim.keymap.set('n', '<leader>bg', '<Plug>(cokeline-pick-focus)', { desc = 'Picker focus buffer' })
		vim.keymap.set('n', '<leader>bc', '<Plug>(cokeline-pick-close)', { desc = 'Picker close buffer' })
		vim.keymap.set('n', '<leader>bh', '<Plug>(cokeline-switch-prev)', { desc = 'Switch pre' })
		vim.keymap.set('n', '<leader>bl', '<Plug>(cokeline-switch-next)', { desc = 'Switch next' })

		require('cokeline').setup({
			default_hl = {
				fg = function(buffer)
					return buffer.is_focused and get_hex('TabLine', 'fg') or get_hex('TabLineFill', 'fg')
				end,
				bg = function(buffer)
					return buffer.is_focused and get_hex('TabLine', 'bg') or get_hex('TabLineFill', 'bg')
				end,
			},
			history = { enabled = false },
			mappings = {
				disable_mouse = true,
			},
			tabs = {
				placement = 'right',
				components = {
					{
						text = function(tabpage)
							if #vim.api.nvim_list_tabpages() == 1 then
								return ''
							end
							return (not tabpage.is_first) and '▏' or ' '
						end,
						fg = function()
							return get_hex('Normal', 'fg')
						end,
						bg = function(tabpage)
							return tabpage.is_active and get_hex('Added', 'fg') or get_hex('Normal', 'bg')
						end,
					},
					{
						text = function(tabpage)
							if #vim.api.nvim_list_tabpages() == 1 then
								return ''
							end
							return tabpage.number .. ' '
						end,
						fg = function(tabpage)
							return tabpage.is_active and get_hex('Search', 'fg') or get_hex('Normal', 'fg')
						end,
						bg = function(tabpage)
							return tabpage.is_active and get_hex('Added', 'fg') or get_hex('TabLine', 'bg')
						end,
					},
				},
			},
			components = {
				{
					text = function(buffer)
						return buffer.is_first and ' ' or ''
					end,
				},
				{
					text = function(buffer)
						return (buffer.index ~= 1) and '▏' or ''
					end,
					fg = function()
						return get_hex('Normal', 'fg')
					end,
				},
				{
					text = function(buffer)
						local icon, _ = MiniIcons.get('file', buffer.filename)
						return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. ' ' or icon .. ' '
					end,
					fg = function(buffer)
						local _, hl = MiniIcons.get('file', buffer.filename)
						return (is_picking_focus() and yellow) or (is_picking_close() and red) or get_hex(hl, 'fg')
					end,
					italic = function()
						return (is_picking_focus() or is_picking_close())
					end,
					bold = function()
						return (is_picking_focus() or is_picking_close())
					end,
				},
				{
					text = function(buffer)
						return buffer.filename .. ' '
					end,
					bold = function(buffer)
						return buffer.is_focused
					end,
				},
				{
					text = '✘',
					on_click = function(_, _, _, _, buffer)
						buffer:delete()
					end,
					fg = function()
						return get_hex('ErrorMsg', 'fg')
					end,
				},
				{
					text = ' ',
				},
			},
		})
	end,
}
