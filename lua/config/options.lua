local opt = vim.opt

-- Security
opt.exrc = true
opt.secure = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.synmaxcol = 200

-- UI
opt.termguicolors = true
opt.winborder = 'solid'
opt.winblend = 0
opt.pumblend = 0
opt.pumheight = 10
opt.cmdheight = 1
opt.laststatus = 3
opt.ruler = false
opt.showmode = false
opt.confirm = true
opt.mouse = 'a'

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Cursor
opt.cursorline = true
opt.cursorcolumn = false
opt.scrolloff = 4
opt.sidescrolloff = 8

-- Window & Split
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = 'screen'
opt.winminwidth = 5

-- Wrap
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- Fold
opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = 'expr'
-- Make it greater than 0 if you want to see the fold column.
opt.foldcolumn = '0'

-- Indent
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = -1
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.grepprg = 'rg --vimgrep'
opt.grepformat = '%f:%l:%c:%m'
opt.inccommand = 'nosplit'

-- File
opt.autowrite = true
opt.undofile = true
opt.undolevels = 10000
opt.sessionoptions = {
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
opt.virtualedit = 'block'
opt.jumpoptions = 'view'

-- Status column
opt.signcolumn = 'yes'

-- Clipboard
opt.clipboard:append('unnamedplus')

-- List
opt.list = true
opt.listchars = {
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
opt.fillchars = {
	foldopen = '',
	foldclose = '',
	fold = ' ',
	foldsep = '│',
	diff = '╱',
	eob = ' ',
}
