return {
  "axieax/urlview.nvim",
  lazy = false,
  config = function()
    require("urlview").setup({
      default_picker = "telescope",
      default_action = "firefox",
      jump = {
        next = "gp",
        prev = "gP",
      },
    })
  end,
}
