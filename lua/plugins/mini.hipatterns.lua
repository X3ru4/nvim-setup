return {
	"nvim-mini/mini.hipatterns",
	event = "VeryLazy",
	version = false,
	opts = {
		highlighters = {
			-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
			fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
			hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
			todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
			note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

			warning = { pattern = "%f[%w]()WARNING()%f[%W]", group = "MiniHipatternsHack" },
			warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsHack" },
			error = { pattern = "%f[%w]()ERROR()%f[%W]", group = "MiniHipatternsFixme" },
			bug = { pattern = "%f[%w]()BUG()%f[%W]", group = "MiniHipatternsFixme" },
		},
	},
}
