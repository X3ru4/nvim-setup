local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("MyGroup", { clear = true })

-- Highlight on yank.
autocmd("TextYankPost", {
  group = group,
	callback = function()
		vim.hl.on_yank({ higroup = "Yank", timeout = 150, priority = 10000 })
	end,
})

-- Alway show statusline when in in command mode.
-- autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
--   group = group,
-- 	callback = function(event)
-- 		vim.o.cmdheight = (event.event == "CmdlineEnter") and 1 or 0
-- 	end,
-- })

-- Reload config.highlight when colorscheme changed.
autocmd("ColorScheme", {
  group = group,
	callback = function()
		vim.cmd("SetupHl")
	end,
})

-- Setup highlights
autocmd("UiEnter", {
  group = group,
	once = true,
	callback = function()
		vim.cmd("SetupHl")
	end,
})

autocmd("LspAttach", {
  group = group,
  callback = function (ev)
    require("config.keymaps").lsp(ev.buf)
  end
})
