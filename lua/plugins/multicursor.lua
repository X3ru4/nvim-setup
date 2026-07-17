return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	enabled = true,
	keys = function()
		local mc = require("multicursor-nvim")
		local mode = { "n", "x" }
		return {
			{
				mode = mode,
				"<C-Up>",
				function()
					mc.lineAddCursor(-1)
				end,
			},
			{
				mode = mode,
				"<C-Down>",
				function()
					mc.lineAddCursor(1)
				end,
			},
			{
				mode = mode,
				"<leader><up>",
				function()
					mc.lineSkipCursor(-1)
				end,
			},
			{
				mode = mode,
				"<leader><down>",
				function()
					mc.lineSkipCursor(1)
				end,
			},

			-- Add or skip adding a new cursor by matching word/selection
			{
				mode = mode,
				"<leader>n",
				function()
					mc.matchAddCursor(1)
				end,
			},
			{
				mode = mode,
				"<leader>x",
				function()
					mc.matchSkipCursor(1)
				end,
			},
			{
				mode = mode,
				"<leader>N",
				function()
					mc.matchAddCursor(-1)
				end,
			},
			{
				mode = mode,
				"<leader>X",
				mc.matchSkipCursor,
			},
			{
				mode = mode,
				"<leader>a",
				mc.matchAllAddCursors,
			},
			{
				mode = mode,
				"<leader>j",
				mc.addCursor,
			},
		}
	end,
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ "n", "x" }, "<left>", mc.prevCursor)
			layerSet({ "n", "x" }, "<right>", mc.nextCursor)

			-- Delete the main cursor.
			layerSet({ "n", "x" }, "<leader>d", mc.deleteCursor)

			-- Enable and clear cursors using escape.
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { link = "Cursor" })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
