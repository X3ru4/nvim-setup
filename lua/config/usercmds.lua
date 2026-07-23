local create_cmd = vim.api.nvim_create_user_command

create_cmd("Loadhl", function()
	dofile(vim.fn.stdpath("config") .. "/lua/config/highlights.lua")
end, {})

create_cmd("Themes", function()
	if not vimu.loader.is_plugin_loaded("fzf-lua") then
		vim.notify("This command is require fzf-lua plugin.", vim.log.levels.ERROR)
		return
	end

	local list = {}
	for _, spec in ipairs(vimu.colorscheme.list) do
		list[#list + 1] = spec.name or spec[1]
	end

	require("fzf-lua").fzf_exec(list, {
		header = "<Cr>: Yank the colorscheme name.\n<Tab>: Load colorscheme.",
		winopts = {
			fullscreen = false,
			border = "rounded",
			title = " Available colorschemes ",
		},
		actions = {
			["enter"] = function(selected)
				vim.fn.setreg("*", selected[1])
			end,
			["tab"] = function(selected)
				pcall(vim.cmd.colorscheme, selected[1])
			end,
		},
	})
end, {})
