local M = {}
local util = require("utility.lazy")
local setkeymap = vim.keymap.set

setkeymap("n", "<leader>rm", "<cmd>!rm ~/.local/state/nvim/swap -rf<cr>", { desc = "Remove swap folder" })
setkeymap("!", "<F11>", "<Nop>")
setkeymap("n", "K", "<Nop>")

-- Better insert
setkeymap("i", "<C-a>", "<C-o>I")

-- Not use this keymap if use cinnamon.nvim
if not util.is_loaded("cinnamon.nvim") then
	setkeymap({ "n", "x" }, "zh", "zH", { desc = 'Horizontal scroll like "zH"' })
	setkeymap({ "n", "x" }, "zl", "zL", { desc = 'Horizontal scroll like "zL"' })
end

-- Yank all
setkeymap("n", "<leader>ya", "ggVGy", { desc = "Yank all" })

-- Window
setkeymap("n", "<leader>wh", "<C-w>h", { desc = "Win left" })
setkeymap("n", "<leader>wj", "<C-w>j", { desc = "Win down" })
setkeymap("n", "<leader>wk", "<C-w>k", { desc = "Win up" })
setkeymap("n", "<leader>wl", "<C-w>l", { desc = "Win right" })
setkeymap("n", "<leader>wo", "<C-w>o", { desc = "Win full" })

-- Buffer
setkeymap("n", "<S-h>", "<cmd>bprevious<cr>")
setkeymap("n", "<S-l>", "<cmd>bnext<cr>")
setkeymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
setkeymap("n", "<leader>bb", "<cmd>buffer #<cr>", { desc = "Previous buffer" })

-- Quick select
setkeymap({ "n", "x" }, "<leader>v", "gg0vG$", { desc = "Select all" })
setkeymap({ "n", "x" }, "<leader>V", "ggVG$", { desc = "Select all line" })

-- Return Normal mode
setkeymap("t", "<C-b>", "<cmd>e #<cr><cmd>e #<cr>")
-- Save file
setkeymap({ "n", "x", "i" }, "<C-s>", "<cmd>silent!w<cr><esc>", { desc = "Save file", silent = true })
-- Quit
setkeymap("n", "<leader>qa", "<cmd>q!<cr>", { desc = "Quit all" })
setkeymap("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
-- lazy.nvim
setkeymap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- <leader>g
-- Source
setkeymap("n", "<leader>gg", function()
	vim.cmd("silent! w")
	vim.cmd("source %")
end, { desc = "Source" })
-- Open term
setkeymap("n", "<leader>gt", "<cmd>terminal<cr><cmd>startinsert<cr>", { desc = "Open terminal" })
-- Replace select
setkeymap("x", "<leader>gr", function()
	local reg = vim.fn.getreg('"')
	local regtype = vim.fn.getregtype('"')
	vim.cmd('normal! "vy')
	local selection = vim.fn.getreg('"')
	vim.fn.setreg('"', reg, regtype)

	vim.ui.input({ prompt = 'Replace "' .. selection .. '" with' }, function(input)
		if input then
			vim.ui.input({ prompt = 'Flag-Ex: "gc"' }, function(flag)
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
setkeymap("n", "<leader>gs", function()
	vim.ui.input({ prompt = "Search  " }, function(input)
		if type(input) == "string" then
			vim.cmd("?" .. input)
		end
	end)
end, { desc = "Search" })
-- Reopen file
setkeymap("n", "<leader>gf", "<cmd>e!<cr>", { desc = "Reopen" })

-- Editor
-- No need more than one cursor
-- map("n", "<leader>n", "*Nciw", { desc = "Search & Replace" })

-- <leader>c
setkeymap("n", "<leader>cb", function ()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, { desc = "Toggle background" })
setkeymap("n", "<leader>cw", function()
	if not vim.o.wrap then
		vim.opt.wrap = true
	else
		vim.opt.wrap = false
	end
end, { desc = "Wrap" })
setkeymap("n", "<leader>cr", function()
	local method = "make"
	vim.cmd("silent! w")
	if method == "make" then
		vim.cmd("terminal make run")
	elseif method == "shell" then
		vim.cmd("terminal ./run.sh")
	end
end, { desc = "Run code" })

function M.lsp(_, bufnr)
	-- Code action
	setkeymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })

	-- Inlay hint
	setkeymap("n", "<leader>ch", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = "Toggle inlay hint", buffer = bufnr })

	-- If not use the fzf-lua swith to use the default
	if not util.is_loaded("fzf-lua") then
		setkeymap("n", "grd", vim.lsp.buf.definition, { desc = "Definition", buffer = bufnr })
		setkeymap("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr })
		setkeymap("n", "grr", vim.lsp.buf.references, { desc = "References", buffer = bufnr })
		setkeymap("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition", buffer = bufnr })
	else
		local fzf = require("fzf-lua")
		setkeymap("n", "grd", fzf.lsp_definitions, { desc = "Definition", buffer = bufnr })
		setkeymap("n", "gri", fzf.lsp_implementations, { desc = "Implementation", buffer = bufnr })
		setkeymap("n", "grr", fzf.lsp_references, { desc = "References", buffer = bufnr })
		setkeymap("n", "grt", fzf.lsp_typedefs, { desc = "Type definition", buffer = bufnr })
	end

	setkeymap({ "n", "i" }, "<C-k>", function()
		vim.lsp.buf.signature_help({
			border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
			focus = false,
			close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
		})
	end, { desc = "Signature help", buffer = bufnr })

	setkeymap({ "n", "i" }, "<C-l>", function()
		vim.diagnostic.open_float(nil, {
			border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
			focus = false,
			close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
		})
	end, { desc = "Open diagnostic float", buffer = bufnr })
end

-- ©LazyVim
-- Better up/down
setkeymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
setkeymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
setkeymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
setkeymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
setkeymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
setkeymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
setkeymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
setkeymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
setkeymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
setkeymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
setkeymap("i", ",", ",<C-g>u")
setkeymap("i", ".", ".<C-g>u")
setkeymap("i", ";", ";<C-g>u")

-- Better indents
setkeymap("v", "<", "<gv")
setkeymap("v", ">", ">gv")

-- commenting
setkeymap("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
setkeymap("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- diagnostic
local jump_to = function(count, severity)
	return function()
		vim.diagnostic.jump({
			count = count,
			severity = vim.diagnostic.severity[severity],
		})
	end
end
setkeymap({ "n", "x" }, "]d", jump_to(1), { desc = "Next Diagnostic" })
setkeymap({ "n", "x" }, "[d", jump_to(-1), { desc = "Prev Diagnostic" })
setkeymap({ "n", "x" }, "]e", jump_to(1, "ERROR"), { desc = "Next Error" })
setkeymap({ "n", "x" }, "[e", jump_to(-1, "ERROR"), { desc = "Prev Error" })
setkeymap({ "n", "x" }, "]w", jump_to(1, "WARN"), { desc = "Next Warning" })
setkeymap({ "n", "x" }, "[w", jump_to(-1, "WARN"), { desc = "Prev Warning" })

-- Clear search
setkeymap({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

return M
