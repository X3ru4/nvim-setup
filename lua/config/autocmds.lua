local cmd = vim.api.nvim_create_autocmd

cmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

cmd({ "CmdlineEnter", "CmdlineLeave" }, {
	callback = function(event)
		vim.o.cmdheight = (event.event == "CmdlineEnter") and 1 or 0
	end,
})

-- set wrap when FileType is json
cmd("FileType", {
	pattern = "*",
	callback = function(args)
		vim.o.wrap = (args.match == "json")
	end,
})

-- Reload highlight.lua when colorscheme changed.
cmd("ColorScheme", {
	callback = function()
		require("config.highlight").setup()
	end,
})

-- -- Auto show diagnostic when CursorMoved and CursorMovedI
-- cmd("CursorHold", {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, {
-- 			border = "rounded",
-- 			focus = false,
-- 			close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
-- 		})
-- 	end,
-- })
