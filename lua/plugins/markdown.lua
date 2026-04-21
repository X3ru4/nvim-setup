return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
    cmd = "RenderMarkdown",
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			completions = {
				blink = { enabled = true },
			},
		},
	},
}
