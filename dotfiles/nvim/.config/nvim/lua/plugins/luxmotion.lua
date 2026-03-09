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
				duration = 200,
				easing = "ease-in-out",
			},
			scroll = {
				duration = 250,
				easing = "ease-out",
			},
		})
	end,
}
