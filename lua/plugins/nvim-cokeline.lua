return {
	'willothy/nvim-cokeline',
	event = { 'BufNewFile', 'BufReadPre' },
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

		local buf_icons = {}
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
						return get_hex('Comment', 'fg')
					end,
				},
				{
					text = function(buffer)
						if is_picking_focus() or is_picking_close() then
							return buffer.pick_letter .. ' '
						else
							if not buf_icons[buffer.number] then
								local icon, hl = MiniIcons.get('file', buffer.filename)
								buf_icons[buffer.number] = {
									icon = icon,
									color = get_hex(hl, 'fg'),
								}
							end
							return buf_icons[buffer.number].icon .. ' '
						end
					end,
					fg = function(buffer)
						return (is_picking_focus() and yellow) or (is_picking_close() and red) or buf_icons[buffer.number].color
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
					fg = function(buffer)
						return buffer.is_modified and get_hex('Changed', 'fg') or nil
					end,
					bold = function(buffer)
						return buffer.is_focused or buffer.is_modified
					end,
				},
				{
					text = '✘',
					on_click = function(_, _, _, _, buffer)
						buffer:delete()
					end,
					fg = function(buffer)
						return (buffer.is_focused or buffer.buf_hovered) and get_hex('ErrorMsg', 'fg') or get_hex('Normal', 'fg')
					end,
				},
				{
					text = ' ',
				},
			},
		})

		local group = vim.api.nvim_create_augroup('cokacola', { clear = true })
		vim.api.nvim_create_autocmd('ColorScheme', {
			group = group,
			callback = function()
				buf_icons = {}
			end,
		})
		vim.api.nvim_create_autocmd('BufDelete', {
			group = group,
			callback = function(ev)
				buf_icons[ev.buf] = nil
			end,
		})
	end,
}
