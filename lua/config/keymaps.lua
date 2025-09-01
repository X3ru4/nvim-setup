local map = vim.keymap.set

-- Yank buf
map("n", "<leader>ya", "ggVGy", { desc = "Yank all" })

-- Better switch window
map("n", "<leader>wh", "<c-w>h", { desc = "Win left" })
map("n", "<leader>wj", "<c-w>j", { desc = "Win down" })
map("n", "<leader>wk", "<c-w>k", { desc = "Win up" })
map("n", "<leader>wl", "<c-w>l", { desc = "Win right" })

-- Quick select
map("n", "<leader>v", "gg0vG$", { desc = "Select all" })
map("n", "<leader>V", "ggVG$", { desc = "Select all line" })

-- Go Prev buff in term
map("t", "<C-b>", "<cmd>e #<cr>")
-- Run code
map("n", "<leader>cr", "<cmd>terminal ./run.sh<cr>")
-- Save file
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>silent! w<cr><esc>", { desc = "Save file" })
-- Quit
map("n", "<leader>qa", "<cmd>q!<cr>", { desc = "Quit all" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Source
map("n", "g<leader>g", "<cmd>source %<cr>", { desc = "Source" })
-- Open term
map("n", "g<leader>t", "<cmd>terminal<cr>", { desc = "Open terminal" })
-- Search & Replace
map("n", "g<leader>r", function()
	vim.ui.input({ prompt = "Search" }, function(input)
		if input ~= "" then
			vim.ui.input({ prompt = "Replace " .. input .. " with" }, function(input_)
				vim.cmd("%s/" .. input .. "/" .. input_ .. "/g")
			end)
		end
	end)
end, { desc = "Search & Replace" })

-- Lsp
-- Code action
map("n", "gra", vim.lsp.buf.code_action, { desc = "Code action" })

map("n", "grd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "grr", vim.lsp.buf.references, { desc = "References" })
map("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition" })

map("n", "K", function()
	vim.lsp.buf.hover({
		border = "rounded",
	})
end, { desc = "Lsp hover" })

map({ "i", "n" }, "<c-l>", function()
	vim.diagnostic.open_float(nil, { focus = false, close_events = { "BufWinLeave", "CursorMoved", "InsertEnter" } })
end, { desc = "Open diagnostic float" })

-- Signature help
map("i", "<c-k>", function()
	vim.lsp.buf.signature_help({
		border = "rounded",
	})
end)

-- Reopen file
map("n", "g<leader>f", function()
	local file = vim.fn.expand("%:p")
	vim.cmd("edit " .. file)
end, { desc = "Reopen" })

-- LazyVim
-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

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
local diag_jump = function(count, severity)
	return function()
		vim.diagnostic.jump({
			count = count,
			severity = vim.diagnostic.severity[severity],
		})
	end
end
map("n", "]d", diag_jump(1), { desc = "Next Diagnostic" })
map("n", "[d", diag_jump(-1), { desc = "Prev Diagnostic" })
map("n", "]e", diag_jump(1, "ERROR"), { desc = "Next Error" })
map("n", "[e", diag_jump(-1, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diag_jump(1, "WARN"), { desc = "Next Warning" })
map("n", "[w", diag_jump(-1, "WARN"), { desc = "Prev Warning" })

-- Clear search
map({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
