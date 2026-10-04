return {
	'stephansama/fzf-nerdfont.nvim',
	lazy = true,
	build = ':FzfNerdfont generate',
	dependencies = { 'ibhagwan/fzf-lua' },
	cmd = 'FzfNerdfont',
	keys = {
		{ '<leader>fi', '<CMD>FzfNerdfont<CR>', desc = 'FZF open nerdfont picker' },
	},
	opts = {
		prompt = 'Select Icon: ',
	},
}
