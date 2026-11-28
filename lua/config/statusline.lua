local api = vim.api
local hl = require('utils.highlight')

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
	['r?'] = 'Confirm',
}

local mode_hls = {
	n = 'StatusLineModeNormal',
	i = 'StatusLineModeInsert',
	v = 'StatusLineModeVisual',
	V = 'StatusLineModeVisual',
	['\22'] = 'StatusLineModeVisual',
	c = 'StatusLineModeCommand',
	t = 'StatusLineModeOther',
	R = 'StatusLineModeReplace',
	s = 'StatusLineModeOther',
	nt = 'StatusLineModeNormal',
	no = 'StatusLineModeOperator',
	['!'] = 'StatusLineModeOther',
	niI = 'StatusLineModeNormal',
	niR = 'StatusLineModeNormal',
	niV = 'StatusLineModeNormal',
}

local function ViMode()
	local mode = api.nvim_get_mode().mode
	return '%#' .. (mode_hls[mode] or 'StatusLineModeOther') .. '# ' .. (modes[mode] or mode) .. '▕%*'
end

local function LspActive()
	if next(vim.lsp.get_clients({ bufnr = 0 })) then
		return '%$StatusLineLsp$[LSP] '
	end
	return ''
end

local function Macro()
	local reg = vim.fn.reg_recording()
	if reg ~= '' then
		return '%$StatusLineMacro$@' .. reg .. ' '
	end
	return ''
end

local function Search()
	if vim.v.hlsearch ~= 0 then
		local count = vim.fn.searchcount()
		return '%$StatusLineSearch$' .. count.current .. '/' .. count.total .. ' '
	end
	return ''
end

local function StatusLine()
	return table.concat({
		ViMode(),
		'%#StatusLineB1# %<',
		(vim.bo.buftype == '' or vim.bo.buftype == 'terminal') and '%t' or '%y',
		'%$StatusLineMod$%m',
		'%$StatusLineRO$',
		vim.bo.filetype == 'help' and '%h' or '%r',
		' %* ',
		vim.diagnostic.status(0):gsub(':', ' '),
		' %=%#StatusLineB1#▏%#(',
		LspActive(),
		Macro(),
		Search(),
		'%#)%l:%c ',
	})
end

hl.add_hook(function()
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
		hl.set('StatusLineMode' .. name, { fg = hl.getfg(hi), bold = true, reverse = true })
	end

	hl.set('StatusLineB1', { bg = hl.get_var('Black1', 'StatusLine bg') })
	hl.set('StatusLineMacro', { fg = hl.getfg('Type') })
	hl.set('StatusLineMacro', { fg = hl.getfg('Type') })
	hl.set('StatusLineMod', { fg = hl.getfg('Changed'), bold = true })
	hl.set('StatusLineRO', { fg = hl.getfg('Constant'), bold = true })
	hl.set('StatusLineSearch', { fg = hl.getfg('SpecialChar') })
	hl.set('StatusLineLsp', { fg = hl.getfg('Added') })
	hl.set('StatusLineLsp', { fg = hl.getfg('Added') })
end, true)

local augroup = api.nvim_create_augroup('StatusLineAG', { clear = true })
api.nvim_create_autocmd('ModeChanged', {
	group = augroup,
	pattern = '*:*',
	command = 'redrawstatus',
})

return StatusLine
