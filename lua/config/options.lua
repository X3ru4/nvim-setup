
vim.g.enable_plugin = {
	lazydev_nvim = true,
}

vim.o.foldenable = true
vim.o.timeoutlen = 300

function _G.newfoldtext()
	local line = vim.fn.getline(vim.v.foldstart)
	local count = vim.v.foldend - vim.v.foldstart + 1
	return "  " .. line .. " ↙" .. count
end

vim.g.run_method = "make"

local opt = vim.opt

opt.relativenumber = true
opt.cmdheight = 0

-- Fold
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = "v:lua.newfoldtext()"

-- Wrap
opt.wrap = true
opt.breakindent = true
opt.linebreak = true

opt.number = true
opt.autowrite = true

-- Windown
opt.winblend = 20
opt.pumblend = 20
-- opt.winborder = "single"

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.cursorcolumn = false
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
opt.mouse = "a"
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
opt.list = true
opt.listchars = {
	eol = " ",
	tab = "  ",
	space = " ",
	trail = "·",
	nbsp = " ",
}
opt.guicursor = {
  "n-c:block-Cursor",
  "v:hor20-Cursor",
  "i-ci-ve:ver25-Cursor",
  "r-cr:hor20-Cursor",
  "o:hor50-Cursor",
}
-- opt.listchars = {
-- 	eol = "↩",
-- 	tab = "··",
-- 	space = "·",
-- 	trail = "•",
-- 	nbsp = "ɲ",
-- }
