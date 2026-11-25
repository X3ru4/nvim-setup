local api = vim.api
local augroup = api.nvim_create_augroup('MyInput', { clear = true })
local min_width = 0.6

local function close(win)
	if api.nvim_win_is_valid(win) then
		api.nvim_win_close(win, true)
	end
	vim.cmd.stopinsert()
end

local win
---@param opts? vim.ui.input.Opts Additional options. See |input()|
---@param on_confirm fun(input?: string)
---               Called once the user confirms or abort the input.
---               `input` is what the user typed (it might be
---               an empty string if nothing was entered), or
---               `nil` if the user aborted the dialog.
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.input = function(opts, on_confirm)
	opts = opts or {}

	local buf = api.nvim_create_buf(false, true)
	local width = math.ceil(vim.o.columns * min_width)
	win = api.nvim_open_win(buf, true, {
		relative = 'cursor',
		title = ' 󰌌 Input ',
		title_pos = 'left',
		width = width,
		height = 1,
		row = 1,
		col = 0,
		style = 'minimal',
	})
	vim.cmd.startinsert()

	vim.wo[win].statuscolumn = '%#Title#' .. (opts.prompt or '> ') .. '%*'
	vim.wo[win].winfixbuf = true
	vim.wo[win].wrap = true

	if opts.default then
		api.nvim_buf_set_lines(buf, 0, -1, false, { opts.default })
		api.nvim_win_set_cursor(win, { 1, vim.fn.strchars(opts.default) })
	end

	local map = vim.keymap.set
	map({ 'n', 'i' }, '<esc>', function()
		close(win)
		on_confirm(nil)
	end, { buf = buf })
	map({ 'n', 'i' }, '<cr>', function()
		local input = api.nvim_buf_get_lines(buf, 0, -1, false)[1]
		close(win)
		on_confirm(input)
	end, { buf = buf })
end

api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
	group = augroup,
	callback = function(ev)
		if win ~= ev.win then
			return
		end
		local statuscol_width = vim.fn.strdisplaywidth(vim.wo[ev.win].statuscolumn:match('%%#Title#(.*)%%'))
		local line_width = statuscol_width + vim.fn.strdisplaywidth(api.nvim_buf_get_lines(ev.buf, 0, 1, false)[1])
		local width = api.nvim_win_get_width(ev.win)
		if line_width >= width then
			api.nvim_win_resize(ev.win, width + 1, -1)
		else
			api.nvim_win_resize(ev.win, math.max(math.ceil(vim.o.columns * min_width), line_width + 1), -1)
		end
	end,
})
