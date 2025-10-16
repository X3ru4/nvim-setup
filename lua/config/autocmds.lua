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
