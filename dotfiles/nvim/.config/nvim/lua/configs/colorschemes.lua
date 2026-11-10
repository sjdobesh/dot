return {
  { "TheNiteCoder/mountaineer.vim" },
  { "nvimdev/zephyr-nvim" },
  { "vimcolorschemes/olive-crt.nvim" },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      local lackluster = require("lackluster")
      lackluster.setup({
        -- tweak_color allows you to overwrite the default colors in the lackluster theme
        tweak_color = {
          -- you can set a value to a custom hexcode like' #aaaa77' (hashtag required)
          -- or if the value is 'default' or nil it will use lackluster's default color
          -- lack = "#aaaa77",
          -- lack = "default",
          lack = "#78536f",
          luster = "#536978",
          orange = "#78536f",
          yellow = "default",
          green = "default",
          blue = "default",
          red = "default",
        },
        tweak_background = {
          normal = "#141414",
        },
      })
    end,
  },
  {
    "metalelf0/black-metal-theme-neovim",
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 100,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    opts = {},
  },
  {
    "sainnhe/sonokai",
  },
  {
    "sainnhe/gruvbox-material",
  },
  {
    "savq/melange-nvim",
  },
  {
    "AlexvZyl/nordic.nvim",
  },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "LuxVim/lux.nvim",
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "rafi/awesome-vim-colorschemes",
  },
  { "vague-theme/vague.nvim" },
}
