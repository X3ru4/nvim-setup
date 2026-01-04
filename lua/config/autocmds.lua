local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank.
autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
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
		require("config.highlight").setup()
    require("util.hl_api").clear_cache()
	end,
})

-- Setup config.highlight
autocmd("UiEnter", {
	once = true,
	callback = function()
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
