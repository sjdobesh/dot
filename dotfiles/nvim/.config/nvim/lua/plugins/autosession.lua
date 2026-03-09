return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>at", "<cmd>AutoSession toggle<CR>" },
		{ "<leader>as", "<cmd>AutoSession save<CR>" },
		{ "<leader>ad", "<cmd>AutoSession delete<CR>" },
	},
	config = function()
		require("auto-session").setup({
			suppressed_dirs = {
				"/",
				"~/",
				"~/bin",
				"~/docs",
				"~/repos",
				"~/projects",
			},
		})
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,
}
