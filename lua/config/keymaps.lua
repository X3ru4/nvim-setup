local M = {}
local lazy = require("utility.lazy")
local keymap = vim.keymap.set

keymap("n", "<leader>rm", "<cmd>!rm ~/.local/state/nvim/swap -rf<cr>", { desc = "Remove swap folder" })
keymap("!", "<F11>", "<Nop>")
keymap("n", "K", "<Nop>")

-- Better insert
keymap("i", "<C-a>", "<C-o>I")

keymap("n", "gy", "gvy", { desc = "Yank" })

-- Not use this keymap if use cinnamon.nvim
if not lazy.plugin_loaded("cinnamon.nvim") then
	keymap({ "n", "x" }, "zh", "zH", { desc = 'Horizontal scroll like "zH"' })
	keymap({ "n", "x" }, "zl", "zL", { desc = 'Horizontal scroll like "zL"' })
end

-- Yank all
keymap("n", "<leader>ya", "ggVGy", { desc = "Yank all" })

-- Window
keymap("n", "<leader>w", "<C-w>", { desc = "Window" })

-- Buffer
keymap("n", "<S-h>", "<cmd>bprevious<cr>")
keymap("n", "<S-l>", "<cmd>bnext<cr>")
keymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
keymap("n", "<leader>bb", "<cmd>buffer #<cr>", { desc = "Previous buffer" })

-- Select all
keymap({ "n", "x" }, "<leader>v", "gg0vG$", { desc = "Select all" })

-- Return Normal mode in terminal mode
keymap("t", "<C-b>", "<cmd>e #<cr><cmd>e #<cr>")
-- Save file
keymap({ "n", "x", "i" }, "<C-s>", "<cmd>silent!w<cr><esc>", { desc = "Save file", silent = true })
-- Quit
keymap("n", "<leader>qa", "<cmd>q!<cr>", { desc = "Quit all" })
keymap("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
-- lazy.nvim
keymap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- <leader>g
-- Source
keymap("n", "<leader>gg", function()
	vim.cmd("silent! w")
	vim.cmd("source %")
end, { desc = "Source" })
-- Open term
keymap("n", "<leader>gt", "<cmd>terminal<cr><cmd>startinsert<cr>", { desc = "Open terminal" })
-- Replace select
keymap("x", "<leader>gr", function()
	local reg = vim.fn.getreg('"')
	local regtype = vim.fn.getregtype('"')
	vim.cmd('normal! "vy')
	local selection = vim.fn.getreg('"')
	vim.fn.setreg('"', reg, regtype)

	vim.ui.input({ prompt = 'Replace "' .. selection .. '" with' }, function(input)
		if input then
			vim.ui.input({ prompt = 'Flag | Ex: "gc"' }, function(input_flag)
				local flag = input_flag or "g"
				vim.cmd(string.format("%%s/%s/%s/%s", selection, input, flag))
			end)
		end
	end)
end, { desc = "Replace" })
-- Popup search
keymap({ "n", "x" }, "<leader>gs", function()
	vim.ui.input({ prompt = "Search  " }, function(input)
		if type(input) == "string" then
			vim.cmd("?" .. input)
		end
	end)
end, { desc = "Search" })
-- Re-open file
keymap("n", "<leader>gf", "<cmd>e!<cr>", { desc = "Re-open" })

-- Editor
-- No need more than one cursor
-- map("n", "<leader>n", "*Nciw", { desc = "Search & Replace" })

-- <leader>c
keymap("n", "<leader>cb", function()
	vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, { desc = "Toggle background" }) -- Can not working on some themes
keymap("n", "<leader>cw", function()
	if not vim.o.wrap then
		vim.o.wrap = true
	else
		vim.o.wrap = false
	end
end, { desc = "Wrap" })
keymap("n", "<leader>cr", function()
	local method = "make"
	vim.cmd("silent! w")
	if method == "make" then
		vim.cmd("terminal make run")
	elseif method == "shell" then
		vim.cmd("terminal ./run.sh")
	end
end, { desc = "Run code" })

function M.lsp(bufnr)
	-- Code action
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })

	-- Inlay hint
	keymap("n", "<leader>ch", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = "Toggle inlay hint", buffer = bufnr })

	-- If not use the fzf-lua swith to use the built-in
	if not lazy.plugin_loaded("fzf-lua") then
		keymap("n", "grd", vim.lsp.buf.definition, { desc = "Definition", buffer = bufnr })
		keymap("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr })
		keymap("n", "grr", vim.lsp.buf.references, { desc = "References", buffer = bufnr })
		keymap("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition", buffer = bufnr })
	else
		local fzf = require("fzf-lua")
		keymap("n", "grd", fzf.lsp_definitions, { desc = "Definition", buffer = bufnr })
		keymap("n", "gri", fzf.lsp_implementations, { desc = "Implementation", buffer = bufnr })
		keymap("n", "grr", fzf.lsp_references, { desc = "References", buffer = bufnr })
		keymap("n", "grt", fzf.lsp_typedefs, { desc = "Type definition", buffer = bufnr })
	end

	keymap({ "n", "i" }, "<C-k>", function()
		vim.lsp.buf.signature_help({
			border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
			focus = false,
			close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
		})
	end, { desc = "Signature help", buffer = bufnr })

	keymap({ "n", "i" }, "<C-l>", function()
		vim.diagnostic.open_float(nil, {
			border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
			focus = false,
			close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
		})
	end, { desc = "Open diagnostic float", buffer = bufnr })
end

-- ©LazyVim
-- Better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
keymap("i", ",", ",<C-g>u")
keymap("i", ".", ".<C-g>u")
keymap("i", ";", ";<C-g>u")

-- Better indents
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- commenting
keymap("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
keymap("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- diagnostic
local diagnostic_jump = function(count, severity)
	return function()
		vim.diagnostic.jump({
			count = count,
			severity = vim.diagnostic.severity[severity],
		})
	end
end
keymap({ "n", "x" }, "+d", diagnostic_jump(1), { desc = "Next Diagnostic" })
keymap({ "n", "x" }, "-d", diagnostic_jump(-1), { desc = "Prev Diagnostic" })
keymap({ "n", "x" }, "+e", diagnostic_jump(1, "ERROR"), { desc = "Next Error" })
keymap({ "n", "x" }, "-e", diagnostic_jump(-1, "ERROR"), { desc = "Prev Error" })
keymap({ "n", "x" }, "+w", diagnostic_jump(1, "WARN"), { desc = "Next Warning" })
keymap({ "n", "x" }, "-w", diagnostic_jump(-1, "WARN"), { desc = "Prev Warning" })

-- Clear search
keymap({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

return M
