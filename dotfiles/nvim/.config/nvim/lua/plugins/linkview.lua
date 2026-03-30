return {
  "sjdobesh/linkview.nvim",
  lazy = false,
  config = function()
    require("urlview").setup({
      default_picker = "telescope",
      default_action = "firefox",
      jump = {
        next = "gl",
        prev = "gL",
      },
    })
  end,
}
