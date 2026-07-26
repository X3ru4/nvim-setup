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
		winopts = {
			fullscreen = false,
			border = "rounded",
			title = " Available colorschemes ",
		},
		_headers = { "actions" },
		actions = {
			["enter"] = {
				fn = function(selected)
					vim.fn.setreg("*", selected[1])
				end,
				header = "yank",
			},
			["tab"] = {
				fn = function(selected)
					local ok, _ = pcall(vim.cmd.colorscheme, selected[1])
					if not ok then
						for i, name in ipairs(list) do
							if name == selected[1] then
								pcall(vimu.colorscheme.list[i].config)
								break
							end
						end
					end
				end,
				header = "load",
				reload = true,
			},
		},
	})
end, {})
