local opt = vim.opt
local g = vim.g

function _G.newfoldtext()
	local line = vim.fn.getline(vim.v.foldstart)
	local count = vim.v.foldend - vim.v.foldstart + 1
	return "  " .. line .. " ↙" .. count
end

g.plugin = {
	ai = true, -- Set it to false to have the best performance
}

-- Run `:Themes` command to see all all available colorschemes
-- You can add or configure colorschemes in `lua/config/colorscheme.lua`
g.colorscheme = {
	apply = "shale", -- Default colorscheme
	install = {
		"tairiki",
		"shale", -- High contrast, dark and light, with a modern color palette.
    "vague",
		"vscode",
		"kanagawa",
		"kanagawa-paper",
		"gruvbox-material",
		"catppuccin", -- Popular, cute and pastel color scheme with multiple flavors.
		"tokyonight",
		"everforest",
		"nightfox",
		"gruvbox",
		"edge",
		"onedark",
		-- ...
	},
}

-- Performance
opt.updatetime = 100
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.synmaxcol = 200

opt.relativenumber = true
opt.cmdheight = 1
opt.winblend = 0
opt.pumblend = 0

-- Wrap
opt.wrap = false
opt.breakindent = true
opt.linebreak = true

opt.number = true
opt.autowrite = true

-- Status column
opt.laststatus = 3
opt.signcolumn = "yes"

-- Fold
opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldtext = "v:lua.newfoldtext()" -- Custom foldtext
opt.foldcolumn = "0"

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
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
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
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.spell = false
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

opt.list = true
opt.listchars = {
	eol = " ",
	tab = "  ",
	leadmultispace = "  ",
	extends = "⟩",
	precedes = "⟨",
	space = " ",
	trail = "·",
	nbsp = "␣",
}

opt.guicursor = {
	"n-c:block-Cursor",
	"v:block-Cursor",
	"i-ci-ve:ver25-Cursor",
	"r-cr:hor20-Cursor",
	"o:hor50-Cursor",
}
