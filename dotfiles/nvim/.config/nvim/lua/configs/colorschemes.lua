return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 100,
    config = function()
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    opts = {},
  },
  {
    "sainnhe/sonokai",
    config = function()
      vim.g.sonokai_enable_italic = true
      --vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "sainnhe/gruvbox-material",
  },
  {
    "savq/melange-nvim",
  },
  {
    "AlexvZyl/nordic.nvim",
    config = function()
      vim.g.sonokai_enable_italic = true
      -- vim.cmd.colorscheme("nordic")
    end,
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
}
