return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		require("auto-session").setup({
			pre_save_cmds = { "Otree" }, -- or "NvimTreeClose"
			post_restore_cmds = { "Otree" }, -- or "NvimTreeOpen"
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
