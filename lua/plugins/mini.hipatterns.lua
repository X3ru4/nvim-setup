return {
	'nvim-mini/mini.hipatterns',
	version = false,
	event = 'VeryLazy',
	opts = {
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
			hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
			todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
			note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
		},
	},
}
