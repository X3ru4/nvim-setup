return {
	'mason-org/mason.nvim',
	event = 'VeryLazy',
	opts = {
		ui = {
			height = 0.8,
			border = nil,
			backdrop = 100,
			icons = {
				package_installed = vime.has_nerdfont and ' ' or nil,
				package_pending = vime.has_nerdfont and ' ' or nil,
				package_uninstalled = vime.has_nerdfont and ' ' or nil,
			},
		},
	},
}
