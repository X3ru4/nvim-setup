return {
	'ofer987/vim-caser',
	event = 'BufReadPost',
	init = function()
		vim.g.caser_no_mappings = 1
	end,
	config = function()
		local function map(key, case, desc)
			vim.keymap.set('n', vim.g.caser_prefix .. key, '<Plug>Caser' .. case, { desc = desc })
			vim.keymap.set('x', vim.g.caser_prefix .. key, '<Plug>CaserV' .. case, { desc = desc })
		end

		map('p', 'MixedCase', 'PascalCase')
		map('c', 'CamelCase', 'camelCase')
		map('_', 'SnakeCase', 'snake_case')
		map('t', 'TitleCase', 'Title Case')
		map('s', 'SentenceCase', 'Sentence case')
		map('<space>', 'SpaceCase', 'space case')
		map('k', 'KebabCase', 'kebab-case')
		map('K', 'TitleKebabCase', 'Title-Kebab-Case')
		map('.', 'DotCase', 'dot.case')
	end,
}
