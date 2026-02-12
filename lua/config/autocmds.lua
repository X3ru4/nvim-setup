local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank.
autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "Yank", timeout = 150, priority = 10000 })
	end,
})

-- Alway show statusline when in in command mode.
autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
	callback = function(event)
		vim.o.cmdheight = (event.event == "CmdlineEnter") and 1 or 0
	end,
})

-- Reload config.highlight when colorscheme changed.
autocmd("ColorScheme", {
	callback = function()
		vim.cmd("SetupHl")
	end,
})

-- Setup config.highlight
autocmd("UiEnter", {
	once = true,
	callback = function()
		vim.cmd("SetupHl")
	end,
})
