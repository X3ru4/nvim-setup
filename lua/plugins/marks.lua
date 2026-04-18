return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
    event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>h", "<Nop>", { desc = "Harpoon" })

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "Harpoon add mark" })
			vim.keymap.set("n", "<leader>hx", function()
				harpoon:list():clear()
			end, { desc = "Harpoon clear marks" })

			local function fzf_harpoon(list)
				local filepaths = {}
				for _, item in ipairs(list.items) do
					table.insert(filepaths, item.value)
				end

				require("fzf-lua").fzf_exec(filepaths, {
					prompt = " ",
					winopts = {
						fullscreen = false,
						border = "rounded",
            title = " Harpoon Marks ",
					},
					file_icons = true,
					actions = {
						["enter"] = require("fzf-lua").actions.file_edit,
					},
				})
			end

			vim.keymap.set("n", "<leader>hf", function()
				fzf_harpoon(harpoon:list())
			end, { desc = "Harpoon quick menu" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>hh", function()
				harpoon:list():prev()
			end, { desc = "Harpoon prev" })
			vim.keymap.set("n", "<leader>hl", function()
				harpoon:list():next()
			end, { desc = "Harpoon next" })
		end,
	},
}
