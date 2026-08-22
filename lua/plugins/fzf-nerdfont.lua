return {
	'stephansama/fzf-nerdfont.nvim',
	lazy = true,
	build = ':FzfNerdfont generate',
	dependencies = { 'ibhagwan/fzf-lua' },
	cmd = 'FzfNerdfont',
	keys = {
		{ '<leader>fi', '<CMD>FzfNerdfont<CR>', desc = 'Open fzf nerd font picker' },
	},
	opts = {
		prompt = 'Select Icon: ',
	},
}
