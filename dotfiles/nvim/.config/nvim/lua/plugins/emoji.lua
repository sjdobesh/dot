return {
	"allaman/emoji.nvim",
	version = "1.0.0", -- optionally pin to a tag
	-- ft = { "markdown", "c", "h" }, -- adjust to your needs
	dependencies = {
		-- optional for nvim-cmp integration
		"hrsh7th/nvim-cmp",
		-- optional for telescope integration
		"nvim-telescope/telescope.nvim",
		-- optional for fzf-lua integration via vim.ui.select
		"ibhagwan/fzf-lua",
	},
	keys = {
		{
			"<leader>te",
		},
	},
	opts = {
		enable_cmp_integration = true,
	},
	config = function(_, opts)
		require("emoji").setup(opts)
		-- optional for telescope integration
		local ts = require("telescope").load_extension("emoji")
		vim.keymap.set("n", "<leader>te", ts.emoji, { desc = "emoji picker" })
	end,
}
