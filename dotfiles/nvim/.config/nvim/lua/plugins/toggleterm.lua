return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "tt", "<Cmd>ToggleTerm<CR>" },
    { "th", "<Cmd>ToggleTerm direction='horizontal'<CR>" },
    { "tv", "<Cmd>ToggleTerm direction='vertical'<CR>" },
    {
      "tn",
      function()
        local name = vim.fn.input("terminal name:")
        vim.cmd("ToggleTerm " .. name)
      end,
    },
    { "ts", "<Cmd>ToggleTermSendVisualSelection<CR>" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    direction = "float",
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
      width = 60,
      height = 20,
      row = 0,
      col = 80,
      winblend = 3,
      title_pos = "center", -- 'left' | 'center' | 'right', position of the title of the floating window
    },
  },
}
