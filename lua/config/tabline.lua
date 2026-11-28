local api = vim.api

local function list_buf()
	return vim.tbl_filter(function(buf)
		return vim.bo[buf].buflisted
	end, api.nvim_list_bufs())
end

local function get_bufdata()
	local current_buf = api.nvim_get_current_buf()
	local data = {}
	for _, buf in ipairs(list_buf()) do
		local bufname = api.nvim_buf_get_name(buf)
		table.insert(data, {
			buf = buf,
			current = buf == current_buf,
			name = bufname,
			tail = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]',
			head = vim.fn.fnamemodify(bufname, ':h:t'),
		})
	end
	for idx1, chunk1 in ipairs(data) do
		if not data[idx1].unique and chunk1.name ~= '' then
			for idx2, chunk2 in ipairs(data) do
				if idx1 ~= idx2 and not data[idx2].unique and chunk1.tail == chunk2.tail then
					if chunk1.head == chunk2.head then
						data[idx1].unique = vim.fn.pathshorten(vim.fn.fnamemodify(chunk1.name, ':~:h')) .. '/'
						data[idx2].unique = vim.fn.pathshorten(vim.fn.fnamemodify(chunk2.name, ':~:h')) .. '/'
					else
						data[idx1].unique = chunk1.head .. '/'
						data[idx2].unique = chunk2.head .. '/'
					end
				end
			end
		end
	end
	return data
end

local TabsLength = 0
local BlCurrentContextIdx = 1
local BlUpdate = true
local BlCache = ''
local function Buffers()
	if not BlUpdate then
		return BlCache
	end
	local bufdata = get_bufdata()
	local contexts = {}
	local cumul_length, start_pos = 0, 0
	for idx, chunk in ipairs(bufdata) do
		local context = table.concat({
			' ',
			chunk.unique or '',
			chunk.tail or '',
			vim.bo[chunk.buf].modified and '[+]' or '',
			' ',
		})
		contexts[idx] = context
		if chunk.current then
			BlCurrentContextIdx = idx
			start_pos = cumul_length + 1
		end
		cumul_length = cumul_length + #context
	end

	local line = table.concat(contexts)
	local width = vim.o.columns - TabsLength
	local truncated = start_pos < #line - width
	BlCache = ''

	local length = 0
	for idx, context in ipairs(contexts) do
		local modified = vim.bo[bufdata[idx].buf].modified
		local primary_hl = bufdata[idx].current and 'TabLineBufferCurrent' or 'TabLineBuffer'
		local accent_hl = bufdata[idx].current and 'TabLineBufferCurrentModified' or 'TabLineBufferModified'
		local hl = '%#' .. primary_hl .. '#' .. (modified and '%$' .. accent_hl .. '$' or '')
		if truncated then
			if idx >= BlCurrentContextIdx then
				length = length + #context
				if length < width then
					BlCache = BlCache .. hl .. context
				else
					BlCache = BlCache .. hl .. context:sub(1, #context - (length - width))
					break
				end
			end
		else
			BlCache = BlCache .. hl .. context
		end
	end

	BlCache = BlCache .. '%*'
	BlUpdate = false
	return BlCache
end

local TabsUpdate = true
local TabsCache = ''
local function Tabs()
	if not TabsUpdate then
		return TabsCache
	end
	local tabs = api.nvim_list_tabpages()
	if #tabs < 2 then
		TabsLength = 0
		return ''
	end
	local current_tab = api.nvim_get_current_tabpage()
	TabsCache = ''
	TabsLength = 0
	for _, tab in ipairs(tabs) do
		local tabnr = api.nvim_tabpage_get_number(tab)
		local tabnr_str = tostring(tabnr)
		TabsCache = table.concat({
			TabsCache,
			'%',
			tabnr_str,
			'T',
			'%#',
			tab == current_tab and 'TabLineTabCurrent' or 'TabLineTab',
			'#',
			tab ~= current_tab and '%$TabLineTabSep$▏' or ' ',
			tabnr_str,
			' %T',
		})
		TabsLength = TabsLength + #tostring(tab) + 2
	end
	TabsCache = TabsCache .. '%*'
	return TabsCache
end

local function TabLine()
	return Buffers() .. '%=' .. Tabs()
end

local augroup = api.nvim_create_augroup('TabLineAG', { clear = true })
api.nvim_create_autocmd({ 'BufEnter', 'BufLeave' }, {
	group = augroup,
	callback = function()
		BlUpdate = true
	end,
})
api.nvim_create_autocmd('OptionSet', {
	group = augroup,
	pattern = 'modified',
	callback = function()
		BlUpdate = true
		vim.cmd.redrawtabline()
	end,
})
api.nvim_create_autocmd({ 'TabNew', 'TabClosed', 'TabEnter', 'TabMoved' }, {
	group = augroup,
	callback = function()
		TabsUpdate = true
	end,
})

local hl = require('utils.highlight')
hl.add_hook(function()
	local fill = hl.get('TabLineFill')
	local tabline = hl.get('TabLine')
	hl.set('TabLineBuffer', { fg = fill.fg, bg = fill.bg })
	hl.set('TabLineBufferCurrent', { fg = tabline.fg, bg = hl.getbg('TabLineSel') })
	hl.set('TabLineBufferModified', { fg = hl.getfg('Changed') })
	hl.set('TabLineBufferCurrentModified', { fg = hl.getfg('Changed'), bg = hl.getbg() })
	hl.set('TabLineTab', { link = 'Normal' })
	hl.set('TabLineTabCurrent', { fg = hl.getfg('Added'), bold = true, reverse = true })
	hl.set('TabLineTabSep', { fg = tabline.fg })
end, true)

return TabLine
