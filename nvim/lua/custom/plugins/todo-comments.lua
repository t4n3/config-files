return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{ "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODO's with telescope" },
	},
	--config = function()
	--	local keymap = vim.keymap
	--	keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODO's with telescope" })
	--end,
}
