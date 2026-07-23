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
opt.winborder = "rounded"
opt.winblend = 0
opt.pumblend = 0
opt.pumheight = 10
opt.cmdheight = 1
opt.laststatus = 3
opt.ruler = false
opt.showmode = false
opt.confirm = true
opt.mouse = "a"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Cursor
opt.cursorline = true
opt.cursorcolumn = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.guicursor = {
	"n-c:block-Cursor",
	"v:block-Cursor",
	"i-ci-ve:ver25-Cursor",
	"r-cr:hor20-Cursor",
	"o:hor50-Cursor",
}

-- Window & Split
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.winminwidth = 5

-- Wrap
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- Fold
opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldcolumn = "0"

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
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.inccommand = "nosplit"

-- File
opt.autowrite = true
opt.undofile = true
opt.undolevels = 10000
opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"help",
	"globals",
	"skiprtp",
	"folds",
}

-- Editing
opt.virtualedit = "block"
opt.jumpoptions = "view"
opt.formatoptions = "jcrq"

-- Completion
opt.wildmode = "longest:full,full"

-- Spell
opt.spell = false
opt.spelllang = { "en" }

-- Status column
opt.signcolumn = "yes"

-- Clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- List
opt.list = true
opt.listchars = {
	eol = " ",
	tab = "  ",
	leadmultispace = "  ",
	extends = "›",
	precedes = "‹",
	space = "·",
	trail = "•",
	nbsp = "␣",
}

-- Fillchars
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = "",
	foldsep = "│",
	diff = "╱",
	eob = " ",
}

-- Messages
opt.shortmess:append({
	W = true,
	I = true,
	c = true,
	C = true,
})
