return {
	"rebelot/heirline.nvim",
	enabled = true,
	event = "UiEnter",
	dependencies = {
		"mini.icons",
	},
	config = function()
		local ln = require("utility.line")
		local hl = require("utility.highlight")
		local mini_icons = require("mini.icons")
		local statusline = require("config.extra_options").statusline

		local mode_color = {
			n = "ModeNormal",
			i = "ModeInsert",
			v = "ModeVisual",
			V = "ModeVisual",
			["\22"] = "ModeVisual",
			c = "ModeCommand",
			t = "ModeOther",
			R = "ModeReplace",
			s = "ModeVisual",
		}

		local search_count = {
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
					local search = self.search
					return string.format(" %d/%d", search.current, math.min(search.total, search.maxcount))
				end
				return ""
			end,
			hl = "WarningMsg",
		}

		local vim_mode = {
			update = { "ModeChanged", "BufWinLeave" },
			init = function(self)
				self.mode = vim.fn.mode(1):sub(1, 1)
			end,
			static = {
				os_icon = mini_icons.get("os", vim.loop.os_uname().sysname),
				mode_name = {
					n = "Normal",
					i = "Insert",
					v = "Visual",
					V = "Visual-Line",
					["\22"] = "Visual-Block",
					c = "Command",
					t = "Terminal",
					R = "Replace",
					s = "Select",
				},
			},
			provider = function(self)
				return ln.separator({
					id = "Mode",
					middle = {
						str = ln.padding(self.os_icon, 1, 1) .. (self.mode_name[self.mode] or self.mode) .. " ",
						hl = {
							fg = { "ModeOther" },
							bg = {
								list = mode_color,
								default_key = "n",
								key = self.mode,
							},
							gui = { bold = true, italic = false },
						},
					},
					right = {
						str = statusline.separator[1],
						hl = {
							fg = {
								list = mode_color,
								default_key = "n",
								key = self.mode,
								"bg",
							},
							bg = { "Dark3", "fg" },
						},
					},
				})
			end,
		}

		local file_info = {
			update = { "BufWinEnter", "BufWinLeave", "FileType", "BufModifiedSet", "Colorscheme" },
			init = function()
				hl.advance_hl("HeirlineDark2", {
					fg = { "StatusLine" },
					bg = { "Dark2", "fg" },
				})
				hl.set("HeirlineMod", {
					fg = hl.getfg("WarningMsg"),
					bold = true,
				})
				hl.set("HeirlineRon", {
					fg = hl.getfg("ErrorMsg"),
					bold = true,
				})
				hl.set("HeirlineDark2Sep", {
					fg = hl.getfg("Dark2"),
					bg = hl.getbg("StatusLine"),
				})
				hl.set("HeirlineDark3Sep", {
					fg = hl.getfg("Dark3"),
					bg = hl.getfg("Dark2")
				})
			end,
			hl = "HeirlineDark2",
			{
				provider = statusline.separator[1],
				hl = "HeirlineDark3Sep",
			},
			{
				init = function (self)
					self.icon, self.hl = mini_icons.get("filetype", vim.bo.filetype)
				end,
				provider = function (self)
					return " " ..self.icon .. " "
				end,
				hl = function (self)
					return self.hl
				end
			},
			{
				provider = "%{&filetype == '' ? 'Unknown' : toupper(&filetype[0]) . &filetype[1:]} ",
			},
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = "%m ",
				hl = "HeirlineMod",
			},
			{
				condition = function()
					return vim.bo.readonly
				end,
				provider = "%r ",
				hl = "HeirlineRon",
			},
			{
				provider = statusline.separator[1],
				hl = "HeirlineDark2Sep",
			},
		}

		local macro = {
			update = { "RecordingEnter", "RecordingLeave" },
			condition = function()
				return vim.fn.reg_recording() ~= ""
			end,
			provider = function()
				return "  [" .. vim.fn.reg_recording() .. "]"
			end,
			hl = "Type",
		}

		local diagnostic = {
			update = { "DiagnosticChanged" },
			static = {
				icons = require("config.icons").diagnostic,
			},
			init = function(self)
				local count = vim.diagnostic.count(0)

				self.error = count[vim.diagnostic.severity.ERROR] or 0
				self.warn = count[vim.diagnostic.severity.WARN] or 0
				self.hint = count[vim.diagnostic.severity.HINT] or 0
				self.info = count[vim.diagnostic.severity.INFO] or 0

				self.diagnostic = {
					{ count = self.error, icon = self.icons.Error, icon_hl = "DiagnosticError" },
					{ count = self.warn, icon = self.icons.Warn, icon_hl = "DiagnosticWarn" },
					{ count = self.hint, icon = self.icons.Hint, icon_hl = "DiagnosticHint" },
					{ count = self.info, icon = self.icons.Info, icon_hl = "DiagnosticInfo" },
				}
			end,
			provider = function(self)
				local t = {}
				for _, info in ipairs(self.diagnostic) do
					if info.count > 0 then
						t[#t + 1] = string.format("%s %%#%s#%s %%#StatusLine#", info.count, info.icon_hl, info.icon)
					end
				end

				return table.concat(t)
			end,
		}

		local cursor_pos = {
			update = "CursorMoved",
			provider = " %{mode() == 'i' ? '󰗧' : '󰇀'} %l·%c ",
		}

		require("heirline").setup({
			statusline = {
				vim_mode,
				file_info,
				{ provider = " " },
				diagnostic,
				{ provider = "%=" },
				search_count,
				macro,
				cursor_pos,
			},
		})
	end,
}
