return {
	'malewicz1337/oil-git.nvim',
	ft = 'oil',
	opts = {
		symbols = {
			file = {
				added = ' ',
				modified = ' ',
				renamed = ' ',
				deleted = ' ',
				copied = ' ',
				conflict = ' ',
				untracked = ' ',
				ignored = ' ',
			},
			directory = {
				added = ' ',
				modified = ' ',
				renamed = ' ',
				deleted = ' ',
				copied = ' ',
				conflict = ' ',
				untracked = ' ',
				ignored = ' ',
			},
		},
		highlights = {
			OilGitAdded = { link = 'Added' },
			OilGitModified = { link = 'Changed' },
			OilGitRenamed = { link = 'Changed' },
			OilGitDeleted = { link = 'Removed' },
			OilGitCopied = { link = 'DiagnosticHint' },
			OilGitConflict = { link = 'Function' },
			OilGitUntracked = { link = 'Comment' },
			OilGitIgnored = { link = 'Ignore' },
		},
	},
}
