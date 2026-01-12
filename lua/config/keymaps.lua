local map = vim.keymap.set
local util = require("util.lazy")
local m1 = { "n", "x" }

-- Paste in insert mode.
map("i", "<c-p>", "<c-o>p")

map("n", "<leader>rm", "<cmd>!rm ~/.local/state/nvim/swap -rf<cr>", { desc = "Remove swap folder" })
map("!", "<F11>", "<Nop>")

-- Better insert
map("i", "<c-a>", "<c-o>I")

if not util.is_loaded("cinnamon.nvim") then
  vim.keymap.set(m1, "zh", "zH", { desc = "Horizontal scroll" })
  vim.keymap.set(m1, "zl", "zL", { desc = "Horizontal scroll" })
end

-- Yank buffer
map("n", "<leader>ya", "ggVGy", { desc = "Yank all" })

-- Better switch window
map("n", "<leader>wh", "<c-w>h", { desc = "Win left" })
map("n", "<leader>wj", "<c-w>j", { desc = "Win down" })
map("n", "<leader>wk", "<c-w>k", { desc = "Win up" })
map("n", "<leader>wl", "<c-w>l", { desc = "Win right" })

-- Buffer
map("n", "<s-h>", "<cmd>bprevious<cr>")
map("n", "<s-l>", "<cmd>bnext<cr>")
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bb", "<cmd>buffer #<cr>", { desc = "Previous buffer" })

-- Quick select
map("n", "<leader>v", "gg0vG$", { desc = "Select all" })
map("n", "<leader>V", "ggVG$", { desc = "Select all line" })
map("x", "<leader>v", "gg0G$", { desc = "Select all" })

-- Return Normal mode
map("t", "<C-b>", "<cmd>e #<cr><cmd>e #<cr>")
-- Save file
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>silent!w<cr><esc>", { desc = "Save file" })
-- Quit
map("n", "<leader>qa", "<cmd>q!<cr>", { desc = "Quit all" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
-- lazy.nvim
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- <leader>g
-- Source
map("n", "<leader>gg", function()
	vim.cmd("silent! w")
	vim.cmd("source %")
end, { desc = "Source" })
-- Open term
map("n", "<leader>gt", "<cmd>terminal<cr><cmd>startinsert<cr>", { desc = "Open terminal" })
-- Replace select
map("x", "<leader>gr", function()
	local save_reg = vim.fn.getreg('"')
	local save_regtype = vim.fn.getregtype('"')
	vim.cmd('normal! "vy')
	local selection = vim.fn.getreg('"')
	vim.fn.setreg('"', save_reg, save_regtype)

	vim.ui.input({ prompt = 'Replace "' .. selection .. '" with' }, function(input)
		if input then
			vim.ui.input({ prompt = 'Flag Ex: "gc"' }, function(flag)
				vim.cmd(table.concat({
					"%s/",
					selection,
					"/",
					input,
					"/",
					flag or "g",
				}))
			end)
		end
	end)
end, { desc = "Replace" })
-- Popup search
map("n", "<leader>gs", function()
	vim.ui.input({ prompt = "Search" }, function(input)
		if type(input) == "string" then
			vim.cmd("?" .. input)
		end
	end)
end, { desc = "Search" })
-- Reopen file
map("n", "<leader>gf", function()
	local file = vim.fn.expand("%:p")
	vim.cmd("edit " .. file)
end, { desc = "Reopen" })

-- Editor
-- No need more than one cursor
-- map("n", "<leader>n", "*Nciw", { desc = "Search & Replace" })

-- Code
map(m1, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>ch", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Inlay hint" })
map("n", "<leader>cw", function()
	if not vim.o.wrap then
		vim.opt.wrap = true
	else
		vim.opt.wrap = false
	end
end, { desc = "Wrap" })
map("n", "<leader>cr", function()
	local method = "make"
	vim.cmd("silent! w")
	if method == "make" then
		vim.cmd("terminal make run")
	elseif method == "shell" then
		vim.cmd("terminal ./run.sh")
	end
end, { desc = "Run code" })

-- Lsp
map("n", "grd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "grr", vim.lsp.buf.references, { desc = "References" })
map("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition" })

map({ "n", "i" }, "<c-k>", function()
	vim.lsp.buf.signature_help({
		border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
		focus = false,
		close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
	})
end)

map({ "i", "n" }, "<c-l>", function()
	vim.diagnostic.open_float(nil, {
		border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
		focus = false,
		close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
	})
end, { desc = "Open diagnostic float" })

-- ©LazyVim
-- Better up/down
map(m1, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map(m1, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map(m1, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map(m1, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Better indents
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- diagnostic
local jump_to = function(count, severity)
	return function()
		vim.diagnostic.jump({
			count = count,
			severity = vim.diagnostic.severity[severity],
		})
	end
end
map(m1, "]d", jump_to(1), { desc = "Next Diagnostic" })
map(m1, "[d", jump_to(-1), { desc = "Prev Diagnostic" })
map(m1, "]e", jump_to(1, "ERROR"), { desc = "Next Error" })
map(m1, "[e", jump_to(-1, "ERROR"), { desc = "Prev Error" })
map(m1, "]w", jump_to(1, "WARN"), { desc = "Next Warning" })
map(m1, "[w", jump_to(-1, "WARN"), { desc = "Prev Warning" })

-- Clear search
map({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
