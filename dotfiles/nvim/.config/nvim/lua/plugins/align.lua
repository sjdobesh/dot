return {
  "Vonr/align.nvim",
  branch = "v2",
  lazy = true,
  keys = {
    {
      "aa",
      function()
        require("align").align_to_char({
          length = 1,
        })
      end,
      mode = "x",
      desc = "align by char",
    },
    {
      "ap",
      function()
        require("align").align_to_char({
          preview = true,
          length = 2,
        })
      end,
      mode = "x",
      desc = "align to character with preview",
    },
    {
      "aw",
      function()
        require("align").align_to_string({
          preview = true,
          regex = false,
        })
      end,
      mode = "x",
      desc = "align to word",
    },
    {
      "ar",
      function()
        require("align").align_to_string({
          preview = true,
          regex = true,
        })
      end,
      desc = "align to regex",
    },
  },
}
