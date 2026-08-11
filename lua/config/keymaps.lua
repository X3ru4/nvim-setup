local map = vim.keymap
map.set('n', '<Home>', '0', { remap = true })
map.set('n', '<End>', '$', { remap = true })

map.set('n', '<leader>gt', '<Cmd>terminal<Cr>i', { desc = 'Open terminal' })

map.set('n', '<leader>re', '<Cmd>restart<Cr>', { desc = 'Restart Neovim' })
map.set('n', '<leader>ro', '<Cmd>e!<Cr>', { desc = 'Re-open' })
map.set('n', '<leader>rm', '<Cmd>!rm ~/.local/state/nvim/swap -rf<Cr>', { desc = 'Remove swap folder' })

map.set('n', '<leader>co', '<Cmd>normal! gg=G\'\'<Cr>', { desc = 'Indent' })
map.set('n', '<leader>cr', '<Cmd>silent! w | terminal make run<Cr>', { desc = 'Run code' })
map.set('n', '<leader>cw', '<Cmd>set wrap!<Cr>', { desc = 'Wrap' })
map.set(
	'n',
	'<leader>cb',
	'<Cmd>let &background=&background == \'dark\' ? \'light\' : \'dark\'<Cr>',
	{ desc = 'Toggle background' }
)
map.set({ 'n', 'x' }, '<leader>v', '<Cmd>norm gg0vG$h<Cr>', { desc = 'Select all' })
map.set('i', '<C-a>', '<C-o>I', { desc = 'Move the cursor back to the first character' })
map.set({ 'n', 'x' }, 'zh', 'zH', { desc = 'Horizontal scroll like "zH"' })
map.set({ 'n', 'x' }, 'zl', 'zL', { desc = 'Horizontal scroll like "zL"' })
map.set('n', '<S-h>', '<Cmd>bprevious<cr>')
map.set('n', '<S-l>', '<Cmd>bnext<cr>')
map.set('n', '<leader>bd', '<Cmd>bdelete<cr>', { desc = 'Delete buffer' })
map.set('n', '<leader>bb', '<Cmd>buffer #<cr>', { desc = 'Previous buffer' })
map.set({ 'n', 'x', 'i' }, '<C-s>', '<Cmd>silent!w<cr><esc>', { desc = 'Save file', silent = true })
map.set('n', '<leader>qa', '<Cmd>q!<cr>', { desc = 'Quit all' })
map.set('n', '<leader>qq', '<Cmd>q<cr>', { desc = 'Quit' })
map.set('n', '<leader>l', '<Cmd>Lazy<cr>', { desc = 'Lazy' })

-- Better up/down
map.set({ 'n', 'x' }, 'k', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'Up', expr = true, silent = true })
map.set({ 'n', 'x' }, 'j', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'Down', expr = true, silent = true })
map.set({ 'n', 'x' }, '<Up>', 'v:count == 0 ? \'gk\' : \'k\'', { desc = 'Up', expr = true, silent = true })
map.set({ 'n', 'x' }, '<Down>', 'v:count == 0 ? \'gj\' : \'j\'', { desc = 'Down', expr = true, silent = true })

-- Undo point
map.set('i', ',', ',<C-g>u')
map.set('i', '.', '.<C-g>u')
map.set('i', ';', ';<C-g>u')

-- Commenting
map.set('n', 'gco', 'o<esc>Vcx<esc><Cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
map.set('n', 'gcO', 'O<esc>Vcx<esc><Cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

map.set({ 'i', 'n', 's' }, '<esc>', function()
	vim.cmd('noh')
	return '<esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })
