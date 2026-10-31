local set = vim.keymap.set

set('n', '<leader>re', '<cmd>restart<cr>', { desc = 'Restart Neovim' })
set('n', '<leader>ro', '<cmd>e!<cr>', { desc = 'Re-open' })
set('n', '<leader>rm', '<cmd>!rm ~/.local/state/nvim/swap -rf<cr>', { desc = 'Remove swap folder' })

set('n', '<leader>cr', '<cmd>silent! w | terminal make run<cr>', { desc = 'make run' })
set('n', '<leader>cw', '<cmd>set wrap!<cr>', { desc = 'Wrap' })
set(
	'n',
	'<leader>cb',
	[[<cmd>let &background=&background ==# 'dark' ? 'light' : 'dark'<cr>]],
	{ desc = 'Toggle background' }
)
set({ 'n', 'x' }, '<leader>v', '<cmd>norm gg0vG$h<cr>', { desc = 'Select all' })
set({ 'n', 'x' }, 'zh', 'zH', { desc = 'Horizontal scroll like "zH"' })
set({ 'n', 'x' }, 'zl', 'zL', { desc = 'Horizontal scroll like "zL"' })
set('n', '<S-h>', '<cmd>bprevious<cr>')
set('n', '<S-l>', '<cmd>bnext<cr>')
set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
set('n', '<leader>bb', '<cmd>buffer #<cr>', { desc = 'Previous buffer' })
set('n', '<leader>bf', '<cmd>silent! %bd!|e#|bd#<cr>', { desc = 'Focus buffer' })
set({ 'n', 'x', 'i' }, '<C-s>', '<cmd>silent!w<cr><esc>', { desc = 'Save file', silent = true })
set('n', '<leader>qa', '<cmd>q!<cr>', { desc = 'Quit all' })
set('n', '<leader>qq', '<cmd>q<cr>', { desc = 'Quit' })

-- Better up/down
set({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { desc = 'Up', expr = true, silent = true })
set({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { desc = 'Down', expr = true, silent = true })
set({ 'n', 'x' }, '<Up>', [[v:count == 0 ? 'gk' : 'k']], { desc = 'Up', expr = true, silent = true })
set({ 'n', 'x' }, '<Down>', [[v:count == 0 ? 'gj' : 'j']], { desc = 'Down', expr = true, silent = true })

-- Undo point
set('i', ',', ',<C-g>u')
set('i', '.', '.<C-g>u')
set('i', ';', ';<C-g>u')

-- Commenting
set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

set({ 'i', 'n', 's' }, '<esc>', function()
	vim.cmd.nohlsearch()
	return '<esc>'
end, { expr = true, desc = 'Escape and clear hlsearch' })

-- Multicursor
local mcursor = require('vim._core.mcursor')
set({ 'n', 'x' }, '<leader>n', function()
	local last_reg = vim.fn.getreg('/')
	vim.schedule(function()
		vim.cmd('normal! *N1Qnq=')
		vim.cmd.nohlsearch()
		vim.fn.setreg('/', last_reg)
	end)
end)
set({ 'n', 'x' }, '<leader>N', function()
	local last_reg = vim.fn.getreg('/')
	vim.schedule(function()
		vim.cmd('normal! *N1QNq=')
		vim.cmd.nohlsearch()
		vim.fn.setreg('/', last_reg)
	end)
end)
set('n', '<left>', function()
	if mcursor.active() then
		return '[C'
	end
	return '<left>'
end, { expr = true })
set('n', '<right>', function()
	if mcursor.active() then
		return ']C'
	end
	return '<right>'
end, { expr = true })
set('n', '<C-down>', function()
	for _ = 1, vim.v.count1 do
		vim.cmd('normal! Qj')
	end
end)
set('n', '<C-up>', function()
	for _ = 1, vim.v.count1 do
		vim.cmd('normal! Qk')
	end
end)
