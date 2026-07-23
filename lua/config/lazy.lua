-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    vimu.colorscheme.create_spec()
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { vimu.colorscheme.default },
  },
  checker = { enabled = true },
  defaults = {
    lazy = false,
    version = false,
  },
  change_detection = {
    enabled = false,
  },
  ui = {
    border = vim.o.winborder,
    backdrop = 100,
    title = "› LAZY ‹",
    icons = {
      cmd = "󰆍",
      config = "󰒓",
      debug = "󰃤",
      event = "󱐋",
      favorite = "󰋑",
      ft = "󱈖",
      init = "󰒓",
      import = "󰋺",
      keys = "󰌌",
      lazy = "󰒲 ",
      loaded = "",
      not_loaded = "",
      plugin = "󰏓",
      runtime = "󱨚",
      require = "󰢱",
      source = "󰓦",
      start = "",
      task = "󰄬",

      list = {
        "󰧞",
        "›",
        "»",
        "–",
      },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "matchparen",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        -- "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        -- "ftplugin",
      },
    },
  },
})
