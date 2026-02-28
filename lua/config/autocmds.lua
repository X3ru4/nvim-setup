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

-- Setup highlights
autocmd("UiEnter", {
	once = true,
	callback = function()
		vim.cmd("SetupHl")
	end,
})

autocmd("VimEnter", {
  once = true,
  callback = function ()
    vim.notify("Warning X3ru4 is coming!", 3)
  end
})

autocmd("LspAttach", {
  callback = function (ev)
    require("config.keymaps").lsp(ev.buf)
  end
})
