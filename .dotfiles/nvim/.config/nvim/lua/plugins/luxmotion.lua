return {
  "LuxVim/nvim-luxmotion",
  config = function()
    require("luxmotion").setup({
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
  end
}
