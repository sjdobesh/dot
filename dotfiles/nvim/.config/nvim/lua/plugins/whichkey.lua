return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    preset = "helix",
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "see local keymaps",
    },
    {
      "<leader>g?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "see global keymaps",
    },
  },
}
