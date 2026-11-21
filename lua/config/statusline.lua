local api = vim.api
local hl = require('utils.highlight')

local function hltext(hi, text)
	return '%#' .. hi .. '#' .. text
end

local modes = {
	n = 'Normal',
	i = 'Insert',
	v = 'Visual',
	V = 'V-Line',
	['\22'] = 'V-Block',
	c = 'Command',
	t = 'Terminal',
	R = 'Replace',
	s = 'Select',
	nt = 'N-Terminal',
	no = 'O-pending',
	['!'] = 'Shell',
	niI = 'N-Insert',
	niR = 'N-Replace',
	niV = 'N-Virtual',
}

local mode_hls = {
	n = 'MyStlModeNormal',
	i = 'MyStlModeInsert',
	v = 'MyStlModeVisual',
	V = 'MyStlModeVisual',
	['\22'] = 'MyStlModeVisual',
	c = 'MyStlModeCommand',
	t = 'MyStlModeOther',
	R = 'MyStlModeReplace',
	s = 'MyStlModeOther',
	nt = 'MyStlModeNormal',
	no = 'MyStlModeOperator',
	['!'] = 'MyStlModeOther',
	niI = 'MyStlModeNormal',
	niR = 'MyStlModeNormal',
	niV = 'MyStlModeNormal',
}

local function ViMode()
	local mode = api.nvim_get_mode().mode
	return hltext(mode_hls[mode] or 'MyStlModeOther', ' 󰍳 ' .. (modes[mode] or mode) .. '▕%*')
end

local function LspActive()
	if next(vim.lsp.get_clients({ bufnr = 0 })) then
		return hltext('MyStlLsp', ' LSP ')
	end
	return ''
end

local function Macro()
	local reg = vim.fn.reg_recording()
	if reg ~= '' then
		return hltext('MyStlMacro', '@' .. reg .. ' ')
	end
	return ''
end

local function Search()
	if vim.v.hlsearch ~= 0 then
		local count = vim.fn.searchcount()
		return hltext('MyStlSearch', count.current .. '/' .. count.total .. ' ')
	end
	return ''
end

local function StatusLine()
	return table.concat({
		ViMode(),
		hltext('MyStlB1', ' %<' .. ((vim.bo.buftype == '' or vim.bo.buftype == 'terminal') and '%t' or '%y')),
		hltext('MyStlMod', '%m'),
		hltext('MyStlRO', vim.bo.filetype == 'help' and '%h' or '%r'),
		' %* ',
		vim.diagnostic.status(0):gsub(':', ' '),
		'%=',
		hltext('MyStlB1', '▏'),
		LspActive(),
		Macro(),
		Search(),
		hltext('MyStlB1', '%l:%c '),
	})
end

hl.add_hook('StatusLine', function()
	local mode_colors = {
		Normal = 'Added',
		Insert = 'Keyword',
		Visual = 'Removed',
		Command = 'Changed',
		Other = 'Function',
		Replace = 'Statement',
		Operator = 'Constant',
	}

	for name, hi in pairs(mode_colors) do
		hl.set('MyStlMode' .. name, { fg = hl.get_alias('Black', 'Normal bg'), bg = hl.getfg(hi), bold = true })
	end

	local Black1 = hl.get_alias('Black1', 'StatusLine bg')
	hl.set('MyStlB1', { bg = Black1 })
	hl.set('MyStlMacro', { fg = hl.getfg('Type'), bg = Black1 })
	hl.set('MyStlMod', { fg = hl.getfg('Changed'), bg = Black1, bold = true })
	hl.set('MyStlRO', { fg = hl.getfg('Constant'), bg = Black1, bold = true })
	hl.set('MyStlSearch', { fg = hl.getfg('SpecialChar'), bg = Black1 })
	hl.set('MyStlLsp', { fg = hl.getfg('Added'), bg = Black1 })
end, nil, true)

local augroup = api.nvim_create_augroup('MyStlAucmd', { clear = true })
api.nvim_create_autocmd('ModeChanged', {
	pattern = '*:*',
	group = augroup,
	command = 'redrawstatus',
})

return StatusLine
