return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local logo = [[
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
         ░    ░  ░    ░ ░        ░   ░         ░   
                                ░                  
      ]]
    logo = string.rep("\n", 6) .. logo .. "\n"
    opts.config.header = vim.split(logo, "\n")
    opts.config.center = {
      {
        action = "ene | startinsert",
        desc = " New File",
        icon = " ",
        key = "n",
      },
      {
        action = 'lua LazyVim.pick("projects")()',
        desc = " Projects",
        icon = " ",
        key = "p",
      },
      {
        action = "edit ~/.config/nvim",
        desc = " Config",
        icon = " ",
        key = "c",
      },
      {
        action = function()
          vim.api.nvim_input("<cmd>qa<cr>")
        end,
        desc = " Quit",
        icon = " ",
        key = "q",
      },
    }
    opts.config.footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return { "󱐋 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
    end
  end,
}
