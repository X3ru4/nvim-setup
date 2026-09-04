return {
	'rebelot/heirline.nvim',
	event = 'UIEnter',
	config = function()
		local separator = { '', '' }
		local Space = { provider = ' ' }
		local Align = { provider = '%=' }
		local hl = require('utils.highlight')

		local Search_count = {
			condition = function()
				return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
			end,
			init = function(self)
				local ok, search = pcall(vim.fn.searchcount)
				if ok and search.total then
					self.search = search
				end
			end,
			provider = function(self)
				if self.search then
					return ' ' .. self.search.current .. '/' .. math.min(self.search.total, self.search.maxcount)
				end
			end,
			hl = 'WarningMsg',
		}

		local LSPActive = {
			condition = function()
				return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil
			end,
			update = { 'LspAttach', 'LspDetach' },
			provider = '  [LSP]',
			hl = hl.modify('DiagnosticSignInfo', { bold = true })[2],
		}

		local ViMode = {
			update = {
				'ModeChanged',
				pattern = '*:*',
				callback = vim.schedule_wrap(function()
					vim.cmd.redrawstatus()
				end),
			},
			init = function(self)
				self.current_mode = vim.api.nvim_get_mode().mode
				self.current_modehl = self.mode_hl[self.current_mode] or 'ModeOther'
				self.current_modehlsep = 'HeirlineModeSep' .. self.current_modehl
				hl.set(self.current_modehlsep, {
					fg = hl.getbg(self.current_modehl),
					bg = hl.alias.Black3,
				})
			end,
			hl = function(self)
				return self.current_modehl
			end,
			static = {
				mode_hl = {
					n = 'ModeNormal',
					i = 'ModeInsert',
					v = 'ModeVisual',
					V = 'ModeVisual',
					['\22'] = 'ModeVisual',
					c = 'ModeCommand',
					t = 'ModeOther',
					R = 'ModeReplace',
					s = 'ModeVisual',
					no = 'ModeReplace',
					['!'] = 'ModeOther',
				},
				mode_name = {
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
				},
			},
			{
				provider = ' 󰍳 ', -- CREEPER!!
			},
			{
				provider = function(self)
					return (self.mode_name[self.current_mode] or self.current_mode) .. ' '
				end,
			},
			{
				provider = separator[1],
				hl = function(self)
					return self.current_modehlsep
				end,
			},
		}

		local FileInfo = {
			update = { 'BufWinEnter', 'FileType', 'BufModifiedSet' },
			init = function()
				hl.set('HeirlineDark2', {
					fg = hl.getfg('StatusLine'),
					bg = hl.alias.Black2,
				})
				hl.set('HeirlineMod', {
					fg = hl.getfg('Changed'),
				})
				hl.set('HeirlineRon', {
					fg = hl.getfg('Removed'),
					bold = true,
				})
				hl.set('HeirlineDark2Sep', {
					fg = hl.alias.Black2,
					bg = hl.getbg('StatusLine'),
				})
				hl.set('HeirlineDark3Sep', {
					fg = hl.alias.Black3,
					bg = hl.alias.Black2,
				})
			end,
			hl = 'HeirlineDark2',
			{
				provider = separator[1],
				hl = 'HeirlineDark3Sep',
			},
			{
				init = function(self)
					if MiniIcons then
						self.icon, self.hl = MiniIcons.get('filetype', vim.bo.filetype)
					else
						self.icon, self.hl = ' ', ''
					end
				end,
				provider = function(self)
					return ' ' .. self.icon .. ' '
				end,
				hl = function(self)
					return self.hl
				end,
			},
			{
				provider = '%{&filetype == \'\' ? \'Unknown\' : toupper(&filetype[0]) . &filetype[1:]} ',
			},
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = ' ',
				hl = 'HeirlineMod',
			},
			{
				condition = function()
					return vim.bo.readonly or not vim.bo.modifiable
				end,
				provider = ' ',
				hl = 'HeirlineRon',
			},
			{
				provider = function()
					return '%*%#HeirlineDark2Sep#' .. separator[1]
				end,
			},
		}

		local Macro = {
			update = { 'RecordingEnter', 'RecordingLeave' },
			condition = function()
				return vim.fn.reg_recording() ~= ''
			end,
			provider = function()
				return '  (' .. vim.fn.reg_recording() .. ')'
			end,
			hl = 'Type',
		}

		local Diagnostic = {
			condition = function()
				return vim.diagnostic.count(0) ~= {}
			end,
			update = { 'DiagnosticChanged', 'BufEnter' },
			init = function(self)
				self.status = vim.diagnostic.status(0)
			end,
			{
				provider = function(self)
					return self.status:gsub(':', ' ')
				end,
			},
			{
				provider = function(self)
					return self.status
						:gsub('(%s?%%#DiagnosticSignInfo#.-)%%##$', '')
						:gsub('(%s?%%#DiagnosticSignHint#.-)%%##$', '')
						:gsub(':', ' ')
				end,
			},
		}

		local StatusLine = {
			{
				flexible = 20,
				{ ViMode, FileInfo },
				{ ViMode },
				false,
			},
			{
				flexible = 5,
				{
					update = Diagnostic.update,
					init = Diagnostic.init,
					Space,
					Diagnostic[1],
				},
				{
					update = Diagnostic.update,
					init = Diagnostic.init,
					Space,
					Diagnostic[2],
				},
				false,
			},
			Align,
			{
				flexible = 10,
				Search_count,
				false,
			},
			{
				flexible = 15,
				Macro,
				false,
			},
			{
				flexible = 2,
				LSPActive,
				false,
			},
			{
				flexible = 3,
				{ provider = ' %{mode() == \'i\' ? \'󰣈\' : \'\'} %l·%c ' },
				{ provider = ' %l·%c ' },
				{ provider = ' %l ' },
				false,
			},
		}

		require('heirline').setup({ statusline = StatusLine })
	end,
}
