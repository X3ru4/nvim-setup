return {

	{
		"kosayoda/nvim-lightbulb",
		enabled = false,
		event = "LspAttach",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = {
					enabled = true,
					updatetime = 200,
					-- events = { "CursorMoved", "CursorMovedI" }
				},
				sign = {
					enabled = false,
				},
				float = {
					text = "💡",
					enabled = true,
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			local icons = require("config.icons").diagnostic
			local enable = vim.lsp.enable
			local config = vim.lsp.config
			local severity_icons = {
				[vim.diagnostic.severity.ERROR] = icons.Error,
				[vim.diagnostic.severity.WARN] = icons.Warn,
				[vim.diagnostic.severity.INFO] = icons.Info,
				[vim.diagnostic.severity.HINT] = icons.Hint,
			}

			vim.diagnostic.config({
				virtual_text = {
					prefix = function(diagnostic)
						return severity_icons[diagnostic.severity]
					end,
					suffix = "",
				},
				underline = false,
				float = { source = "if_many" },
				update_in_insert = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN] = icons.Warn,
						[vim.diagnostic.severity.INFO] = icons.Info,
						[vim.diagnostic.severity.HINT] = icons.Hint,
					},
				},
			})

			vim.lsp.inlay_hint.enable(false)
			config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						-- Set cargo features to automatically enable all features for completion
						cargo = {
							allFeatures = true,
							-- You can also specify a specific command for check on save, e.g.,
							-- command = "clippy", (instead of the default 'check')
						},
						-- Inlay hints are very useful for Rust
						inlayHints = {
							enable = true,
							-- Further options for hints can be found in the rust-analyzer docs
						},
					},
				},
			})

			config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			config("jsonls", {
				settings = {
					json = {
						schemas = {
							{
								description = "Minecraft Bedrock Manifest",
								fileMatch = { "manifest.json", "manifest.jsonc", "manifest.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/general/manifest.json",
							},
							{
								description = "Minecraft Bedrock World Packs",
								fileMatch = {
									"world_behavior_packs.json",
									"world_behavior_packs.jsonc",
									"world_behavior_packs.json5",
									"world_resource_packs.json",
									"world_resource_packs.jsonc",
									"world_resource_packs.json5",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/general/world_x_packs.json",
							},

							-- Language schemas
							{
								description = "Minecraft Bedrock Language Names",
								fileMatch = { "language_names.json", "language_names.jsonc", "language_names.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/language/language_names.json",
							},
							{
								description = "Minecraft Bedrock Languages",
								fileMatch = { "languages.json", "languages.jsonc", "languages.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/language/languages.json",
							},

							-- Skin pack schemas
							{
								description = "Minecraft Bedrock Skin Pack",
								fileMatch = { "skin_pack/skins.json", "skin_pack/skins.jsonc", "skin_pack/skins.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/skinpacks/skins.json",
							},

							-- Resource Pack schemas
							{
								description = "Minecraft Bedrock Resource Pack Animation Controllers",
								fileMatch = {
									"resource_packs/*/animation_controllers/*.json",
									"resource_packs/*/animation_controllers/*.jsonc",
									"resource_packs/*/animation_controllers/*.json5",
									"*resource*pack*/animation_controllers/*.json",
									"*resource*pack*/animation_controllers/*.jsonc",
									"*resource*pack*/animation_controllers/*.json5",
									"*Resource*Pack*/animation_controllers/*.json",
									"*RP*/animation_controllers/*.json",
									"*rp*/animation_controllers/*.json",
									"*.animation_controller.rp.json",
									"*.rpac.json",
									"*.ac.rp.json",
									"*.rp_ac.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/animation_controllers/animation_controller.json",
							},
							{
								description = "Minecraft Bedrock Resource Pack Animations",
								fileMatch = {
									"resource_packs/*/animations/*.json",
									"*resource*pack*/animations/*.json",
									"*Resource*Pack*/animations/*.json",
									"*RP*/animations/*.json",
									"*rp*/animations/*.json",
									"*.animation.rp.json",
									"*.anim.rp.json",
									"*.a.rp.json",
									"*.rpa.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/animations/actor_animation.json",
							},
							{
								description = "Minecraft Bedrock Attachables",
								fileMatch = {
									"attachables/*.json",
									"*.attachable.json",
									"*.attach.json",
									"*.at.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/attachables/attachables.json",
							},
							{
								description = "Minecraft Bedrock Client Biomes",
								fileMatch = { "biomes_client.json", "biomes_client.jsonc", "biomes_client.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/biomes_client.json",
							},
							{
								description = "Minecraft Bedrock Resource Blocks",
								fileMatch = { "blocks.json", "blocks.jsonc", "blocks.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/blocks.json",
							},
							{
								description = "Minecraft Bedrock Client Entity",
								fileMatch = {
									"entity/*.json",
									"*.entity.rp.json",
									"*.e.rp.json",
									"*.ce.json",
									"*.rpe.json",
									"*.entity.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/entity/entity.json",
							},
							{
								description = "Minecraft Bedrock Fogs",
								fileMatch = {
									"fogs/*.json",
									"*.fog.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/fog/fog.json",
							},
							{
								description = "Minecraft Bedrock Flipbook Textures",
								fileMatch = {
									"flipbook_textures.json",
									"flipbook_textures.jsonc",
									"flipbook_textures.json5",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/flipbook_textures.json",
							},
							{
								description = "Minecraft Bedrock Item Texture",
								fileMatch = { "item_texture.json", "item_texture.jsonc", "item_texture.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/item_texture.json",
							},
							{
								description = "Minecraft Bedrock Texture List",
								fileMatch = { "texture_list.json", "texture_list.jsonc", "texture_list.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/texture_list.json",
							},
							{
								description = "Minecraft Bedrock Resource Pack Items",
								fileMatch = {
									"resource_packs/*/items/*.json",
									"*resource*pack*/items/*.json",
									"*RP*/items/*.json",
									"*.item.rp.json",
									"*.i.rp.json",
									"*.rpi.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/items/items.json",
							},
							{
								description = "Minecraft Bedrock Entity Models",
								fileMatch = {
									"models/entity/*.json",
									"*.geo.json",
									"*.geometry.json",
									"*.model.json",
									"*.g.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/models/entity/model_entity.json",
							},
							{
								description = "Minecraft Bedrock Materials",
								fileMatch = { "materials/*.material" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/materials/materials.json",
							},
							{
								description = "Minecraft Bedrock Music Definitions",
								fileMatch = { "music_definitions.json" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/sounds/music_definitions.json",
							},
							{
								description = "Minecraft Bedrock Particles",
								fileMatch = {
									"particles/*.json",
									"*.particle.json",
									"*.p.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/particles/particles.json",
							},
							{
								description = "Minecraft Bedrock Render Controllers",
								fileMatch = {
									"render_controllers/*.json",
									"*.render.json",
									"*.render_controller.json",
									"*.rc.json",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/render_controllers/render_controllers.json",
							},
							{
								description = "Minecraft Bedrock Sound Definitions",
								fileMatch = {
									"sound_definitions.json",
									"sound_definitions.jsonc",
									"sound_definitions.json5",
								},
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/sounds/sound_definitions.json",
							},
							{
								description = "Minecraft Bedrock Sounds",
								fileMatch = { "sounds.json", "sounds.jsonc", "sounds.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/sounds.json",
							},
							{
								description = "Minecraft Bedrock Terrain Texture",
								fileMatch = { "terrain_texture.json", "terrain_texture.jsonc", "terrain_texture.json5" },
								url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/terrain_texture.json",
							},
						},
						validate = { enable = true },
					},
				},
			})

			enable({ "rust_analyzer", "lua_ls" })
		end,
	},

	{
		"j-hui/fidget.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("fidget").setup({})
			vim.notify = require("fidget").notify
		end,
	},

	{
		"mfussenegger/nvim-lint",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "ruff" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		enabled = false,
		event = "InsertEnter",
		opts = {
			bind = true,
			floating_window = false,
			handler_opts = {
				border = "rounded",
			},
			hint_prefix = "󰅟  ",
		},
	},

	{
		"smjonas/inc-rename.nvim",
		opts = {
			-- input_buffer_type = "dressing",
		},
		keys = {
			{ "grn", ":IncRename ", desc = "Rename" },
		},
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},

	{
		"b0o/schemastore.nvim",
		enabled = false,
		ft = { "json" },
	},
}
