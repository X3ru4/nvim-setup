return {

  -- use colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = _G.colorscheme,
    },
  },

  -- add onedark
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "darker",
      transparent = _G.transparent,
    },
  },

  -- add dracula
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    opts = {
      transparent_bg = _G.transparent,
    },
  },
}
