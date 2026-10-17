return {
	'2kabhishek/nerdy.nvim',
	event = 'VeryLazy',
	config = function()
		local copy_to_clipboard = false
		local register = '+'

		local icons = require('nerdy.icons')
		local items = {}

		for i = 1, #icons do
			local data = icons[i]
			table.insert(items, data.name .. ': ' .. data.char)
		end

		vim.keymap.set('n', '<leader>fi', function()
			require('fzf-lua').fzf_exec(items, {
				prompt = 'Icon: ',
				fzf_opts = { ['--multi'] = true },
				winopts = { title = '  Nerdy Icons ' },
				actions = copy_to_clipboard and {
					['enter'] = function(selected, _)
						local icon = ''
						for _, select in ipairs(selected) do
							icon = icon .. select:match(':%s(.+)')
						end
						vim.fn.setreg(register, icon)
					end,
				} or nil,
				complete = not copy_to_clipboard and function(selected, _, line, col)
					local icon = ''
					for _, select in ipairs(selected) do
						icon = icon .. select:match(':%s(.+)')
					end
					local newline = line:sub(1, col - 1) .. icon .. line:sub(col)
					return newline, col
				end or nil,
			})
		end, { desc = 'FZF Nerdy Icons' })
	end,
}
