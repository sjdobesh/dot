return {
	"josstei/whisk.nvim",
	config = function()
		require("whisk").setup({
			performance = { enabled = true },
			keymaps = {
				cursor = true,
				scroll = true,
			},
			cursor = {
				duration = 150,
				easing = "linear",
			},
			scroll = {
				duration = 150,
				easing = "linear",
			},
		})
	end,
}
