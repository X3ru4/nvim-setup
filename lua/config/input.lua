local api = vim.api

local function close(win)
	if api.nvim_win_is_valid(win) then
		api.nvim_win_close(win, true)
	end
	vim.cmd.stopinsert()
end

local win = 0

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
	local width = math.ceil(vim.o.columns * 0.6)
	win = api.nvim_open_win(buf, true, {
		relative = 'editor',
		title = ' ' .. vim.trim(opts.prompt) .. ' ',
		title_pos = 'center',
		width = width,
		height = 1,
		row = math.floor((vim.o.lines - 3) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = 'minimal',
	})
	vim.wo[win].wrap = true
	vim.cmd.startinsert()

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
		local input = table.concat(api.nvim_buf_get_lines(buf, 0, -1, false))
		close(win)
		on_confirm(input)
	end, { buf = buf })
end

api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
	callback = function(ev)
		if ev.win ~= win then
			return
		end
		api.nvim_win_set_config(ev.win, {
			height = api.nvim_win_text_height(ev.win, {
				start_row = 0,
				end_row = 0,
			}).all,
		})
	end,
})
