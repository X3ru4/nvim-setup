local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank.
autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "Yank", timeout = 200, priority = 1000 })
	end,
})

-- Alway show statusline when in in command mode.
autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
	callback = function(event)
		vim.o.cmdheight = (event.event == "CmdlineEnter") and 1 or 0
	end,
})

-- Set wrap when FileType is json
autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		vim.o.wrap = (vim.bo[args.buf].filetype == "json")
	end,
})

-- Reload config.highlight when colorscheme changed.
autocmd("ColorScheme", {
	callback = function()
		package.loaded["config.highlight"] = nil
		require("config.highlight").setup()
	end,
})

-- Setup config.highlight
autocmd("UiEnter", {
	once = true,
	callback = function()
		package.loaded["config.highlight"] = nil
		require("config.highlight").setup()
	end,
})

-- -- Auto show diagnostic when CursorMoved and CursorMovedI
-- autocmd("CursorHold", {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, {
-- 			border = "rounded",
-- 			focus = false,
-- 			close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
-- 		})
-- 	end,
-- })
