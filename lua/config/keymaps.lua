local keymap = require('utils.keymap')
keymap.set_list({
	{ 'n', '<Home>', '0', { remap = true } },
	{ 'n', '<End>', '$', { remap = true } },

	{ 'n', '<leader>gt', '<Cmd>terminal<Cr>i', { desc = 'Open terminal' } },

	{ 'n', '<leader>re', '<Cmd>restart<Cr>', { desc = 'Restart Neovim' } },
	{ 'n', '<leader>ro', '<Cmd>e!<Cr>', { desc = 'Re-open' } },
	{ 'n', '<leader>rm', '<Cmd>!rm ~/.local/state/nvim/swap -rf<Cr>', { desc = 'Remove swap folder' } },

	{ 'n', '<leader>co', '<Cmd>normal! gg=G\'\'<Cr>', { desc = 'Indent' } },
	{ 'n', '<leader>cr', '<Cmd>silent! w | terminal make run<Cr>', { desc = 'Run code' } },
	{ 'n', '<leader>cw', '<Cmd>set wrap!<Cr>', { desc = 'Wrap' } },
	{
		'n',
		'<leader>cb',
		'<Cmd>let &background=&background == \'dark\' ? \'light\' : \'dark\'<Cr>',
		{ desc = 'Toggle background' },
	},
	{ { 'n', 'x' }, '<leader>v', '<Cmd>norm gg0vG$h<Cr>', { desc = 'Select all' } },
	{ 'i', '<C-a>', '<C-o>I', { desc = 'Move the cursor back to the first character' } },
	{ { 'n', 'x' }, 'zh', 'zH', { desc = 'Horizontal scroll like "zH"' } },
	{ { 'n', 'x' }, 'zl', 'zL', { desc = 'Horizontal scroll like "zL"' } },
	{ 'n', '<S-h>', '<Cmd>bprevious<cr>' },
	{ 'n', '<S-l>', '<Cmd>bnext<cr>' },
	{ 'n', '<leader>bd', '<Cmd>bdelete<cr>', { desc = 'Delete buffer' } },
	{ 'n', '<leader>bb', '<Cmd>buffer #<cr>', { desc = 'Previous buffer' } },
	{ { 'n', 'x', 'i' }, '<C-s>', '<Cmd>silent!w<cr><esc>', { desc = 'Save file', silent = true } },
	{ 'n', '<leader>qa', '<Cmd>q!<cr>', { desc = 'Quit all' } },
	{ 'n', '<leader>qq', '<Cmd>q<cr>', { desc = 'Quit' } },
	{ 'n', '<leader>l', '<Cmd>Lazy<cr>', { desc = 'Lazy' } },

	-- Better up/down
	{ { 'n', 'x' }, 'k', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'Up', expr = true, silent = true } },
	{ { 'n', 'x' }, 'j', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'Down', expr = true, silent = true } },
	{ { 'n', 'x' }, '<Up>', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'Up', expr = true, silent = true } },
	{ { 'n', 'x' }, '<Down>', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'Down', expr = true, silent = true } },

	-- Undo point
	{ 'i', ',', ',<C-g>u' },
	{ 'i', '.', '.<C-g>u' },
	{ 'i', ';', ';<C-g>u' },

	-- Commenting
	{ 'n', 'gco', 'o<esc>Vcx<esc><Cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' } },
	{ 'n', 'gcO', 'O<esc>Vcx<esc><Cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' } },

	{
		{ 'i', 'n', 's' },
		'<esc>',
		function()
			vim.cmd('noh')
			return '<esc>'
		end,
		{ expr = true, desc = 'Escape and Clear hlsearch' },
	},
})
