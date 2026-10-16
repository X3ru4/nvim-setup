return {
	'MeanderingProgrammer/render-markdown.nvim',
	cond = vime.has_nerdfont,
	ft = 'markdown',
	cmd = 'RenderMarkdown',
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = {
			blink = { enabled = true },
		},
	},
}
