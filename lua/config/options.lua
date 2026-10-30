-- Security
vim.opt.exrc = true
vim.opt.secure = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
vim.opt.synmaxcol = 200

-- UI
vim.opt.termguicolors = true
vim.opt.winborder = 'solid'
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.confirm = true
vim.opt.mouse = 'a'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Cursor
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

-- Window & Split
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = 'screen'
vim.opt.winminwidth = 5

-- Wrap
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Fold
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
-- Make it greater than 0 if you want to see the fold column.
vim.opt.foldcolumn = '0'

-- Indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1
vim.opt.smartindent = true
vim.opt.shiftround = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.inccommand = 'nosplit'

-- File
vim.opt.autowrite = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.sessionoptions = {
	'buffers',
	'curdir',
	'tabpages',
	'winsize',
	'help',
	'globals',
	'skiprtp',
	'folds',
}

-- Editing
vim.opt.virtualedit = 'block'
vim.opt.jumpoptions = 'view'

-- Status column
vim.opt.signcolumn = 'yes'

-- Clipboard
vim.opt.clipboard:append('unnamedplus')

-- List
vim.opt.list = true
vim.opt.listchars = {
	eol = ' ',
	tab = '  ',
	leadmultispace = '  ',
	extends = '›',
	precedes = '‹',
	space = '·',
	trail = '•',
	nbsp = '␣',
}

-- Fillchars
vim.opt.fillchars = {
	foldopen = '',
	foldclose = '',
	fold = ' ',
	foldsep = '│',
	diff = '╱',
	eob = ' ',
}
