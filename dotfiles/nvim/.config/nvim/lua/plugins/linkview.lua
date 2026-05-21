return {
  "sjdobesh/linkview.nvim",
  lazy = true,
  keys = {
    "gl",
    "gL",
  },
  config = function()
    require("urlview").setup({
      default_picker = "telescope",
      default_action = "lynx",
      jump = {
        next = "gl",
        prev = "gL",
      },
    })
  end,
}
