local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("MyGroup", { clear = true })

-- Highlight on yank.
autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.hl.on_yank({ higroup = "Yank", timeout = 150, priority = 10000 })
	end,
})

-- Reload config.highlight when colorscheme changed.
autocmd("ColorScheme", {
	group = group,
	callback = function()
		vim.cmd("SetupHl")
	end,
})

-- Render blink-cmp documentation as markdown
autocmd("FileType", {
	group = group,
	pattern = "blink-cmp-documentation",
	callback = function()
		vim.bo.filetype = "markdown"
	end,
})

-- Setup highlights
autocmd("UIEnter", {
	group = group,
	once = true,
	callback = function()
		vim.cmd("SetupHl")
	end,
})

autocmd("LspAttach", {
	group = group,
	callback = function(ev)
		require("config.keymaps").lsp(ev.buf)
	end,
})

autocmd("FileType", {
  group = group,
  pattern = "json",
  callback = function ()
    vim.bo.filetype = "jsonc"
  end
})

autocmd("BufReadPost", {
  group = group,
  pattern = "*.material",
  callback = function ()
    vim.bo.filetype = "jsonc"
  end
})

autocmd("BufReadPost", {
  group = group,
  pattern = "*.molang",
  callback = function ()
    vim.bo.filetype = "c"
  end
})
