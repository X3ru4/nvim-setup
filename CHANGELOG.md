# Changelog

## [1.1.0](https://github.com/X3ru4/nvim-setup/compare/v1.0.1...v1.1.0) (2026-08-29)


### Features

* **config:** enable lazy loading by default and simplify plugin setup ([f018fc2](https://github.com/X3ru4/nvim-setup/commit/f018fc2cb9b0dc0a7ef290f0254b18c8b35d4a4b))
* **heirline:** update statusline icons and bold read‑only flag ([ccb9379](https://github.com/X3ru4/nvim-setup/commit/ccb937922bdff8f9ce20a03e94a5b9309a336566))


### Bug Fixes

* **mini.notify:** stop redirecting Neovim messages and lazy‑load on VeryLazy ([a016399](https://github.com/X3ru4/nvim-setup/commit/a016399ae60cf4ad3346e22a88f6a11a6f46af6e))
* **tiny-cmdline:** enable UI2 after setting cmdheight to correct initialization order ([df6697f](https://github.com/X3ru4/nvim-setup/commit/df6697f2118fb4c8c4429edb5aa1337413e7981c))

## [1.0.1](https://github.com/X3ru4/nvim-setup/compare/v1.0.0...v1.0.1) (2026-08-29)


### Bug Fixes

* **colorscheme:** fallback to gruvchad for nil/'default' variant, strip prefix only for explicit variants ([4a12236](https://github.com/X3ru4/nvim-setup/commit/4a12236b0b84d8ccb6b6944923ddc9bb1194537b))
* **fzf-lua:** set foreground for FzfLuaCursorLine to improve visibility ([23e1b45](https://github.com/X3ru4/nvim-setup/commit/23e1b45e08b6a0f4ac2f3459f08cd83414d43735))

## 1.0.0 (2026-08-27)


### ⚠ BREAKING CHANGES

* rename Loadhl command to LoadHlConfig and update autocmds

### Features

* add cendre plugin to lazy-lock ([57b92bf](https://github.com/X3ru4/nvim-setup/commit/57b92bf3374b080cf52f302db8cd2e4dea4409b1))
* Add custom command line format and title options to tiny-cmdline plugin. ([6124612](https://github.com/X3ru4/nvim-setup/commit/6124612d3add80952136c57773e320101cf0940e))
* Add faster.nvim plugin to Lua plugins. ([79f9faa](https://github.com/X3ru4/nvim-setup/commit/79f9faa52b4670942c210c0722c7895a64acf24f))
* Added nvchad colorscheme capability. ([14a94b2](https://github.com/X3ru4/nvim-setup/commit/14a94b242cf03eea0b1309a9964f8bab810329fb))
* Aesthetic optimization ([4db4cb9](https://github.com/X3ru4/nvim-setup/commit/4db4cb9b43d8ef5317ed44c8e02237c887775561))
* **all:** optimization ([8085005](https://github.com/X3ru4/nvim-setup/commit/80850058fd202a79b994831eeee87e65cc49888a))
* **all:** optimization ([9b0922f](https://github.com/X3ru4/nvim-setup/commit/9b0922fed09bf4305bc628c68a0c058a19a5055a))
* **all:** optimization ([94ca45e](https://github.com/X3ru4/nvim-setup/commit/94ca45e56178377a7ebaaa6144b82a0a7836a287))
* **all:** update something ([9c9a98c](https://github.com/X3ru4/nvim-setup/commit/9c9a98cc4b71eaede7b57f194c92c5332d0b239b))
* change a few things ([744396a](https://github.com/X3ru4/nvim-setup/commit/744396a406b4fc13a1fddb7205d66057cbbd40db))
* **ci:** add Release Please workflow for automated releases ([b4c2e28](https://github.com/X3ru4/nvim-setup/commit/b4c2e289b07fc5288b82306428565fceecabda16))
* **colorscheme:** add flume.nvim plugin configuration ([2133ea5](https://github.com/X3ru4/nvim-setup/commit/2133ea59fbeff7f2cd1ef126110e1032b2c67065))
* **colorscheme:** add nvchad base46 configuration with catppuccin theme ([5a17f62](https://github.com/X3ru4/nvim-setup/commit/5a17f6279bc155aa8be32e2d6b3f41f8b7ed8084))
* **config:** remove unnecessary diagnostics configuration. ([782bb37](https://github.com/X3ru4/nvim-setup/commit/782bb37862ae62000dfba73a2846732ccb003c4c))
* configure nvim-lint to support Lua with luacheck ([b5e2f3b](https://github.com/X3ru4/nvim-setup/commit/b5e2f3b9c76eb15cdc2c9b6da6cae9524f223872))
* **config:** use ember colorscheme default and disable blinkcmp borders ([b63d38e](https://github.com/X3ru4/nvim-setup/commit/b63d38e599984a9e1233ad9c0fc8d93e1c2c26ba))
* enable fullscreen mode in fzf-lua plugin by default. ([9973926](https://github.com/X3ru4/nvim-setup/commit/99739265545eb784bab2ee65e8fdb082c0f4e0e2))
* **fzf-lua:** add winborder support and enhance preview highlights ([90a71dc](https://github.com/X3ru4/nvim-setup/commit/90a71dc8fbbbd16a1a22d23b48b38d188d1d0ae7))
* **heirline:** add support for '!' mode with ModeOther and display name "Shell" ([9ccf9f4](https://github.com/X3ru4/nvim-setup/commit/9ccf9f4580abfd092b17fdbabb6a63c4d99a6348))
* **keymaps:** introduce utility.keymap and batch set keymaps ([0f641d3](https://github.com/X3ru4/nvim-setup/commit/0f641d3a51e892132cbe2fdd636eda8f799c2763))
* **lazy-lock:** Update dependencies to the latest commit hashes. ([f88bcc0](https://github.com/X3ru4/nvim-setup/commit/f88bcc0e2e4c98761d1a13ed141bebc06ae7531f))
* **lazy:** Add variant colorscheme loading and handle nvchad removal. ([a6f1b67](https://github.com/X3ru4/nvim-setup/commit/a6f1b6749d8f5970d0683f8305a05139856e6173))
* **lazy:** Update dependencies to latest commits. ([5852b2c](https://github.com/X3ru4/nvim-setup/commit/5852b2c01cb089b609063cdfef0e6392c0ff665c))
* **lsp:** add rust-analyzer ([0e986d6](https://github.com/X3ru4/nvim-setup/commit/0e986d651e6f22d4c146bd4f4e034d77b8bf41a7))
* **lua/plugins/colorscheme:** Add Ember theme to colorscheme plugin. ([f01514a](https://github.com/X3ru4/nvim-setup/commit/f01514adc41caef1207ceda420f780a7754d4be1))
* **lua/plugins:** Add blink pairs plugin and remove mini pairs plugin. ([7191aef](https://github.com/X3ru4/nvim-setup/commit/7191aeff28392fb3e9dbc0b1cd11628a5e0d5774))
* **mini.ai:** Add AI-powered text objects with number and indent specifications. ([2bba87a](https://github.com/X3ru4/nvim-setup/commit/2bba87a2c14a42562702e91ecdb4f82709ef65a8))
* **mini.icons:** custom lsp snippet icon ([5fa178f](https://github.com/X3ru4/nvim-setup/commit/5fa178ff5c83dcb9a4ee490333236c15186dcd5b))
* **mini.notify:** center title by default ([475245b](https://github.com/X3ru4/nvim-setup/commit/475245b3026477c3059cad9fbcd44e5a5e728b6b))
* **mini.notify:** configure custom formatting and UI2 message hook ([4a0157c](https://github.com/X3ru4/nvim-setup/commit/4a0157c060167ecee958f67be35d5a9659a55e0e))
* more authentuc ([d79f0c0](https://github.com/X3ru4/nvim-setup/commit/d79f0c0e0a14c47f5fcdce690efbf1152bdf3517))
* **nvchad:** Add float title styling. ([9416e97](https://github.com/X3ru4/nvim-setup/commit/9416e97f05647427d2792141ff0416e7c8f69394))
* **oil:** Add support for oil-git.nvim plugin, add file and directory symbols, and provide oil winbar function. ([cfdc0c5](https://github.com/X3ru4/nvim-setup/commit/cfdc0c5aaca07c6beb9bf68bac28e1aba6a5472d))
* optimized vision ([b5c7388](https://github.com/X3ru4/nvim-setup/commit/b5c73887fd0e22230b14ea4619e3fe89f3d8f43e))
* optimized vision ([0569695](https://github.com/X3ru4/nvim-setup/commit/05696954d2dc1b3445bf3ccad979e1262263ed3e))
* **package:** Update catppuccin to latest commit. ([107d250](https://github.com/X3ru4/nvim-setup/commit/107d250779e4cfe6380be44824620d5e59aafb5e))
* **plugins:** add some plugins ([68cb5c3](https://github.com/X3ru4/nvim-setup/commit/68cb5c3cc5d321d7b6c46960e180299708383001))
* Remove nvchad theme and replace with base46. ([e9307cc](https://github.com/X3ru4/nvim-setup/commit/e9307cc60045357ad6bd1df70b2695951975633f))
* Removed highlight option for mini.surround plugin. ([ffc67ab](https://github.com/X3ru4/nvim-setup/commit/ffc67abfa88e11c26164f812ec82615ea9d4d76b))
* rename Loadhl command to LoadHlConfig and update autocmds ([3914e47](https://github.com/X3ru4/nvim-setup/commit/3914e4798f87c6b383cbc85dffffeff173c9398a))
* **textobjects:** add basic text object functionality with navigation and repeat. ([474ae30](https://github.com/X3ru4/nvim-setup/commit/474ae301d6b17e07e2c2b26aa418d6c624717ed8))
* **ui:** change window border style from rounded to solid ([cc7d0c1](https://github.com/X3ru4/nvim-setup/commit/cc7d0c176b72a743267a676da09d5b25a12d6ea8))
* **ui:** switch to base46 colorscheme, use rounded window borders and default blinkcmp borders ([2b168fe](https://github.com/X3ru4/nvim-setup/commit/2b168fe6053f02739aee9e9e14288f854069cd99))
* Update Heirline plugin with refined formatting. ([91960d8](https://github.com/X3ru4/nvim-setup/commit/91960d84fb05952231acf68f5fcd0158d7cb2536))
* update plugins and change the snipe.nvim title ([008b62d](https://github.com/X3ru4/nvim-setup/commit/008b62d0dc1d7d34163224bcfaf848b17bfd309c))
* Update plugins and colorscheme for consistent user experience ([76dc1c4](https://github.com/X3ru4/nvim-setup/commit/76dc1c450101f34aa234c67ebaf368222d2e99ad))
* update recommended tools and utilities. ([90307ac](https://github.com/X3ru4/nvim-setup/commit/90307ac62a404c0319ba1b56e7bdf8a06d2a2d3b))
* update theme and icons in config. ([8cbf454](https://github.com/X3ru4/nvim-setup/commit/8cbf4546160d6b0ebb204e4773057579cf65d6bd))
* visual optimization ([a717e0b](https://github.com/X3ru4/nvim-setup/commit/a717e0bb5bc7b370e7f1d76b1f5b2d310eaafbc1))
* zupdate somezig ([8c5c18b](https://github.com/X3ru4/nvim-setup/commit/8c5c18b31943ef594efe55a1cb474f8ee02802c4))


### Bug Fixes

* **colorscheme:** Update base46 color scheme to use teal instead of baby pink for SnacksIndentScope. ([d63e6f7](https://github.com/X3ru4/nvim-setup/commit/d63e6f7244af3b3400d05a308a1002fda0d2ceee))
* **fold:** correct fold column icons and remove filler character ([b48bc7f](https://github.com/X3ru4/nvim-setup/commit/b48bc7f691049c17c3ebc92830d4dd742de045d5))
* **fzf-lua:** use CursorLine background for FzfLuaCursorLine highlight ([7ebd1ba](https://github.com/X3ru4/nvim-setup/commit/7ebd1baf3e4bf46d3e52fff1fedd250285b3cf4a))
* **fzf-oil:** remove dependencies on external oil plugin. ([542a9da](https://github.com/X3ru4/nvim-setup/commit/542a9da72f36f0c16168777a785cfeeabe504f01))
* **guess-indent:** prevent auto command firing in specific filetypes ([4d0ea39](https://github.com/X3ru4/nvim-setup/commit/4d0ea396bfec609de58060d79659703c140ec2df))
* **highlights:** customize Yank highlight with colors/bold and simplify rgb_to_hex API ([9e99b16](https://github.com/X3ru4/nvim-setup/commit/9e99b16714d99f16328a4f4689d5a5729b072875))
* **lazy config:** Update dev path and disable plugin rocks. ([c6aa8d6](https://github.com/X3ru4/nvim-setup/commit/c6aa8d63e71c77d16e9398029c10878a77126b99))
* **mason:** change plugin initialization to only execute on VeryLazy event. ([9d4314c](https://github.com/X3ru4/nvim-setup/commit/9d4314c984faa7f02c961f165fd2a4055c2f43d9))
* Normalize keybinding for action execution. ([4ddc6e0](https://github.com/X3ru4/nvim-setup/commit/4ddc6e0af8bb34f7aa6d755fccbba60fd39032d8))
* **oil:** Remove unnecessary border settings. ([5b4c38d](https://github.com/X3ru4/nvim-setup/commit/5b4c38d2ab0494ef27cc38106c66eca5d26e658e))
* **oil:** use consistent escape key for closing the winbar actions menu. ([31924fe](https://github.com/X3ru4/nvim-setup/commit/31924fe301d69afae28763696196f029610878fe))
* **performance:** Update glyphs for diagnostics, LazyDev, and other plugins. ([fdb10dc](https://github.com/X3ru4/nvim-setup/commit/fdb10dc5d7e5984ae88cb4fdca83de1a3555b85e))
* **refactor blink.cmp config for compatibility with blink.cmp v2:** fix(refactor blink.cmp config for compatibility with blink.cmp v2):  ([067b9a7](https://github.com/X3ru4/nvim-setup/commit/067b9a7687afde35986bb39ba4f352b98b91137d))
* **smear-cursor:** Remove smear-cursor plugin configuration. ([478f1a4](https://github.com/X3ru4/nvim-setup/commit/478f1a40c7be0fbeea55eb525ff61f3adeccb30a))
* update mode indicators in Heirline plugins. ([60f5a6b](https://github.com/X3ru4/nvim-setup/commit/60f5a6b3728d88744e381ce199a99ae01c7f7418))
* Update oil statusline directory highlighting color ([10fab14](https://github.com/X3ru4/nvim-setup/commit/10fab1407f749a53c980aa76bda0f7e71a02dcba))
