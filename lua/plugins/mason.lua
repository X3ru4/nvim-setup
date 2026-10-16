return {
	'mason-org/mason.nvim',
	event = 'VeryLazy',
	opts = {
		ui = {
			height = 0.8,
			border = nil,
			backdrop = 100,
			icons = {
				package_installed = nve.has_nerdfont and ' ' or nil,
				package_pending = nve.has_nerdfont and ' ' or nil,
				package_uninstalled = nve.has_nerdfont and ' ' or nil,
			},
		},
	},
}
