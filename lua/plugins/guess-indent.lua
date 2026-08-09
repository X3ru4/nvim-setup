return {
	'nmac427/guess-indent.nvim',
	event = 'VeryLazy',
	opts = {
		filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
			'netrw',
			'tutor',
			'help',
			'checkhealth',
			'oil',
			'lazy',
			'mason',
			'snipe-menu',
			'alpha',
		},
	},
}
