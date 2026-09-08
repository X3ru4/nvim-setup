# nvim-setup/

<a href="https://dotfyle.com/X3ru4/nvim-setup"><img src="https://dotfyle.com/X3ru4/nvim-setup/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/X3ru4/nvim-setup"><img src="https://dotfyle.com/X3ru4/nvim-setup/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/X3ru4/nvim-setup"><img src="https://dotfyle.com/X3ru4/nvim-setup/badges/plugin-manager?style=flat" /></a>

- ~~Simple Neovim setup.~~
- Blazing fast and highly customizable.
- Many useful features and plugins.
- Language server protocol.
- Completion.
- Snippet.
- Format.
- Lint.
- etc.

## Requirements

### Mandatory

- **A brain**
- **Neovim** release v0.12 or newer
- **Nerd font**
- **git**
- **C compiler** (for building parsers)
- **curl**
- **tree-sitter CLI**
- **ripgrep** (better grep utility)
- **cargo CLI** (for building blink.pairs)
- **fzf** version > 0.36 (for fzf-lua)
- **fd** (better find utility)

### Optional

- **jq CLI** (for fzf-nerdfont)
- **GNU make** (for fzf-nerdfont)
- **pip**
- **npm**
- **git-delta** (syntax highlighted git pager for git status previews)
- **stylua** (lua formater)
- **luarocks**
- **rust toolchain**
- **lua-language-server**

For more details, use the command `:checkhealth`

## Install Instructions

Clone the repository and install the plugins:

```sh
git clone git@github.com:X3ru4/nvim-setup ~/.config/X3ru4/nvim-setup
```

Open Neovim with this config:

```sh
NVIM_APPNAME=X3ru4/nvim-setup/ nvim
```

## Plugins

### color

- [catgoose/nvim-colorizer.lua](https://dotfyle.com/plugins/catgoose/nvim-colorizer.lua)

### colorscheme

- [Aejkatappaja/cendre](https://dotfyle.com/plugins/Aejkatappaja/cendre)
- [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)
- [mitander/flume.nvim](https://dotfyle.com/plugins/mitander/flume.nvim)
- [rebelot/kanagawa.nvim](https://dotfyle.com/plugins/rebelot/kanagawa.nvim)
- [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
- [thesimonho/kanagawa-paper.nvim](https://dotfyle.com/plugins/thesimonho/kanagawa-paper.nvim)
- [smit4k/shale.nvim](https://dotfyle.com/plugins/smit4k/shale.nvim)
- [ellisonleao/gruvbox.nvim](https://dotfyle.com/plugins/ellisonleao/gruvbox.nvim)
- [ember-theme/nvim](https://dotfyle.com/plugins/ember-theme/nvim)
- [navarasu/onedark.nvim](https://dotfyle.com/plugins/navarasu/onedark.nvim)
- [sainnhe/gruvbox-material](https://dotfyle.com/plugins/sainnhe/gruvbox-material)

### completion

- [saghen/blink.cmp](https://dotfyle.com/plugins/saghen/blink.cmp)

### debugging

- [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)

### editing-support

- [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim)
- [X3ru4/boole.nvim](https://dotfyle.com/plugins/X3ru4/boole.nvim)
- [nemanjamalesija/smart-paste.nvim](https://dotfyle.com/plugins/nemanjamalesija/smart-paste.nvim)
- [Wansmer/sibling-swap.nvim](https://dotfyle.com/plugins/Wansmer/sibling-swap.nvim)
- [jake-stewart/multicursor.nvim](https://dotfyle.com/plugins/jake-stewart/multicursor.nvim)

### file-explorer

- [malewicz1337/oil-git.nvim](https://dotfyle.com/plugins/malewicz1337/oil-git.nvim)
- [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)

### formatting

- [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)

### fuzzy-finder

- [ibhagwan/fzf-lua](https://dotfyle.com/plugins/ibhagwan/fzf-lua)

### icon

- [stephansama/fzf-nerdfont.nvim](https://dotfyle.com/plugins/stephansama/fzf-nerdfont.nvim)

### keybinding

- [nvim-mini/mini.clue](https://dotfyle.com/plugins/nvim-mini/mini.clue)

### lsp

- [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)
- [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
- [mason-org/mason.nvim](https://dotfyle.com/plugins/mason-org/mason.nvim)
- [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
- [smjonas/inc-rename.nvim](https://dotfyle.com/plugins/smjonas/inc-rename.nvim)

### markdown-and-latex

- [MeanderingProgrammer/render-markdown.nvim](https://dotfyle.com/plugins/MeanderingProgrammer/render-markdown.nvim)

### nvim-dev

- [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)
- [saghen/blink.lib](https://dotfyle.com/plugins/saghen/blink.lib)
- [OXY2DEV/helpview.nvim](https://dotfyle.com/plugins/OXY2DEV/helpview.nvim)

### plugin-manager

- [zuqini/zpack.nvim](https://dotfyle.com/plugins/zuqini/zpack.nvim)

### session

- [folke/persistence.nvim](https://dotfyle.com/plugins/folke/persistence.nvim)

### snippet

- [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)

### startup

- [goolord/alpha-nvim](https://dotfyle.com/plugins/goolord/alpha-nvim)

### statusline

- [rebelot/heirline.nvim](https://dotfyle.com/plugins/rebelot/heirline.nvim)

### syntax

- [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
- [romus204/tree-sitter-manager.nvim](https://dotfyle.com/plugins/romus204/tree-sitter-manager.nvim)

### utility

- [leath-dub/snipe.nvim](https://dotfyle.com/plugins/leath-dub/snipe.nvim)

## Language Servers

- ember
- jsonls
- lua_ls
- rust_analyzer
- zls

This readme was generated by [Dotfyle](https://dotfyle.com)
