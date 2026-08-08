return {
	'nvim-mini/mini.ai',
	version = false,
	event = 'BufReadPost',
	opts = function()
		local MiniExtra = require('mini.extra')
		return {
			n_lines = 50,
			custom_textobjects = {
				e = {
					{
						'%u[%l%d]+%f[^%l%d]',
						'%f[%S][%l%d]+%f[^%l%d]',
						'%f[%P][%l%d]+%f[^%l%d]',
						'^[%l%d]+%f[^%l%d]',
					},
					'^().*()$',
				},
				d = MiniExtra.gen_ai_spec.number(),
				i = MiniExtra.gen_ai_spec.indent()
			},
			mappings = {
				-- Main textobject prefixes
				around = 'a',
				inside = 'i',

				-- Next/last variants
				-- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
				-- Map LSP selection manually to use it (see `:h MiniAi.config`)
				around_next = 'al',
				inside_next = 'il',
				around_last = 'ah',
				inside_last = 'ih',

				-- Move cursor to corresponding edge of `a` textobject
				goto_left = 'g[',
				goto_right = 'g]',
			},
			silent = true,
		}
	end,
}
