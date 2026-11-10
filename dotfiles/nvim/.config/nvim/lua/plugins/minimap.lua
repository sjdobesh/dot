return {
  "nvim-mini/mini.map",
  keys = {
    {
      "<leader>*",
      function()
        MiniMap.toggle()
      end,
    },
  },
  config = function()
    require("mini.map").setup()
  end,
}
