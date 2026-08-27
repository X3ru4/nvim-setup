return {
	'mason-org/mason.nvim',
	event = 'VeryLazy',
	opts = {
		ui = {
			height = 0.8,
			border = nil,
			backdrop = 100,
			icons = {
				package_installed = ' ',
				package_pending = ' ',
				package_uninstalled = ' ',
			},
		},
	},
}
