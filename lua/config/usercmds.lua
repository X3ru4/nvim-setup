local create_cmd = vim.api.nvim_create_user_command

-- Setup highlighting configuration
create_cmd("SetupHl", function()
	package.loaded["config.highlight"] = nil
	require("config.highlight").setup()
end, {})

-- Show all available themes in a fzf menu
create_cmd("Themes", function()
  local themes = {}
  for name, _ in pairs(require("config.colorscheme")) do
    themes[#themes + 1] = name
  end
  require("fzf-lua").fzf_exec(themes, {
    prompt = " ",
    winopts = {
      fullscreen = false,
      border = "rounded",
      title = " Available Themes ",
    },
  })
end, {})
