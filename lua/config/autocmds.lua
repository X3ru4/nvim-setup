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
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    vim.o.wrap = (args.match == "json")
  end,
})

-- Auto show diagnostic when CursorMoved and CursorMovedI
-- cmd({ "CursorMovedI", "CursorMoved" }, {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, {
-- 			border = "single",
-- 			focus = false,
-- 			close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
-- 		})
-- 	end,
-- })
