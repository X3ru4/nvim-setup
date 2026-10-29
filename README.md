<p align="center">
  <a href="https://dotfyle.com/X3ru4/nvim-setup">
    <img src="https://dotfyle.com/X3ru4/nvim-setup/badges/plugin-manager?style=for-the-badge" alt="Plugin Manager" />
  </a>
  <a href="https://dotfyle.com/X3ru4/nvim-setup">
    <img src="https://dotfyle.com/X3ru4/nvim-setup/badges/plugins?style=for-the-badge" alt="Plugins" />
  </a>
  <a href="https://dotfyle.com/X3ru4/nvim-setup">
    <img src="https://dotfyle.com/X3ru4/nvim-setup/badges/leaderkey?style=for-the-badge" alt="Leader Key" />
  </a>
</p>

<h1 align="center">nvim-setup</h1>

<p align="center">
  A blazing-fast, feature-rich, and highly customizable Neovim configuration.
</p>

---

## Requirements

### Required

| Dependency                                                    | Purpose                       |
| ------------------------------------------------------------- | ----------------------------- |
| [Neovim](https://github.com/neovim/neovim)                    | Version 0.13 or newer         |
| [Git](https://git-scm.com/)                                   | Version control               |
| C compiler                                                    | Build parsers                 |
| [curl](https://curl.se/)                                      | Transfer resources            |
| [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) | Manage parsers                |
| [ripgrep](https://github.com/BurntSushi/ripgrep)              | Fast text searching           |
| [Cargo](https://doc.rust-lang.org/cargo/)                     | Build Rust-based dependencies |
| [fzf](https://github.com/junegunn/fzf)                        | Version newer than 0.36       |
| [fd](https://github.com/sharkdp/fd)                           | Fast file searching           |

### Optional

- **Nerd Font** — Recommended for icons and a better UI.
- **pip** — Python package management.
- **npm** — JavaScript package management.
- **git-delta** — Syntax-highlighted Git diffs.
- **StyLua** — Lua code formatting.
- **LuaRocks** — Lua package management.
- **Rust toolchain** — Rust development tools.
- **lua-language-server** — Lua language support.

## Installation

### 1. Clone the repository

```sh
git clone git@github.com:X3ru4/nvim-setup ~/.config/X3ru4/nvim-setup
```

### 2. Launch Neovim

```sh
NVIM_APPNAME=X3ru4/nvim-setup/ nvim
```

### 3. Check the environment

Inside Neovim, run:

```vim
:checkhealth
```

This command can help identify missing dependencies and configuration issues.

---

<p align="center">
  <sub>Built for Neovim</sub>
</p>
