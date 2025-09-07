local diagnostic = require("config.icons").diagnostic

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
	},
	underline = false,
	float = { border = nil, header = "", source = "if_many" },
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic.errr,
			[vim.diagnostic.severity.WARN] = diagnostic.warn,
			[vim.diagnostic.severity.INFO] = diagnostic.info,
			[vim.diagnostic.severity.HINT] = diagnostic.hint,
		},
	},
})

vim.o.foldenable = true

function _G.newfoldtext()
	local line = vim.fn.getline(vim.v.foldstart)
	local count = vim.v.foldend - vim.v.foldstart + 1
	return "  " .. line .. " ↙" .. count
end

local opt = vim.opt
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = "v:lua.newfoldtext()"
opt.number = true
opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = "~",
}
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.mouse = "a"
opt.pumblend = 20
opt.pumheight = 20
opt.ruler = false
opt.scrolloff = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.list = false
opt.listchars = {
	eol = "",
	tab = "  ",
	space = "·",
	trail = "•",
	extends = "⟩",
	precedes = "⟨",
	nbsp = "ɲ",
}
