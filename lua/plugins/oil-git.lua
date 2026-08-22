return {
	'malewicz1337/oil-git.nvim',
	ft = 'oil',
	opts = {
		show_branch = false,
		highlights = {
			OilGitAdded = { link = 'Added' },
			OilGitBranch = { link = 'Keyword' },
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
