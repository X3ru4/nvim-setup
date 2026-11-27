local api = vim.api

local function list_buf()
	return vim.tbl_filter(function(buf)
		return vim.bo[buf].buflisted
	end, api.nvim_list_bufs())
end

local function get_bufdata()
	local current_buf = api.nvim_get_current_buf()
	local data = {}
	for idx, buf in ipairs(list_buf()) do
		local bufname = api.nvim_buf_get_name(buf)
		data[idx] = {
			buf = buf,
			current = buf == current_buf,
			name = bufname,
			tail = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]',
		}
	end
	for idx1, chunk1 in ipairs(data) do
		if not data[idx1].unique then
			for idx2, chunk2 in ipairs(data) do
				if idx1 ~= idx2 and not data[idx2].unique and chunk1.tail == chunk2.tail then
					data[idx1].unique = vim.fn.fnamemodify(chunk1.name, ':h:t') .. '/'
					data[idx2].unique = vim.fn.fnamemodify(chunk2.name, ':h:t') .. '/'
				end
			end
		end
	end
	return data
end

local TabsLength = 0
local BlCurrentContext = ''
local BlCurrentContextIdx = 1
local BlUpdate = true
local BlCache = ''
local function MakeBufferLine()
	if not BlUpdate then
		return BlCache
	end
	local contexts = {}
	local current_buf = false
	for idx, chunk in ipairs(get_bufdata()) do
		local context = table.concat({
			' ',
			chunk.unique or '',
			chunk.tail or '',
			vim.bo[chunk.buf].modified and '[+]' or '',
			' ',
		})
		table.insert(contexts, context)
		if chunk.current then
			BlCurrentContext = context
			BlCurrentContextIdx = idx
			current_buf = true
		end
	end

	local line = table.concat(contexts)
	local start_pos = (line:find(BlCurrentContext, 1, true)) + 1
	local width = vim.o.columns - TabsLength
	local visible_pos = #line - width
	local truncatable = start_pos < visible_pos
	local length = 0
	BlCache = ''

	for idx, context in ipairs(contexts) do
		if truncatable then
			if idx >= BlCurrentContextIdx then
				length = length + #context
				if length < width then
					BlCache = BlCache .. '%#' .. (current_buf and 'TabLineSel' or 'TabLineFill') .. '#' .. context
				else
					BlCache = BlCache
						.. '%#'
						.. (current_buf and 'TabLineSel' or 'TabLineFill')
						.. '#'
						.. context:sub(1, #context - (length - width))
					break
				end
			end
		else
			BlCache = BlCache .. '%#' .. (current_buf and 'TabLineSel' or 'TabLineFill') .. '#' .. context
		end
	end

	BlCache = BlCache .. '%#TabLineFill#'
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
		TabsCache = table.concat({
			TabsCache,
			'%#',
			tab == current_tab and 'TabLineSel' or 'TabLineFill',
			'#▏' .. tab,
			' ',
		})
		TabsLength = TabsLength + #(' ' .. tab .. ' ')
	end
	TabsCache = TabsCache .. '%*'
	return TabsCache
end

local function TabLine()
	return MakeBufferLine() .. '%=' .. Tabs()
end

local augroup = api.nvim_create_augroup('MyTabLine', { clear = true })
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

return TabLine
