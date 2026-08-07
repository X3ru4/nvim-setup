return {
	'WhoIsSethDaniel/mason-tool-installer.nvim',
	dependencies = { 'mason-org/mason.nvim' },
	cmd = 'MasonToolsInstall',
	opts = {
		ensure_installed = {
			'markdownlint',
			'luacheck',
			'prettier',
		},
		integrations = {
			['mason-lspconfig'] = false,
			['mason-null-ls'] = false,
			['mason-nvim-dap'] = false,
		},
	},
}
