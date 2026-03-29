return {
  "Vonr/align.nvim",
  branch = "v2",
  lazy = true,
  init = function()
    -- Aligns to 1 character
    vim.keymap.set("x", "aa", function()
      require("align").align_to_char({
        length = 1,
      })
    end, { desc = "align by char" })

    -- Aligns to 2 characters with previews
    vim.keymap.set("x", "ap", function()
      require("align").align_to_char({
        preview = true,
        length = 2,
      })
    end, { desc = "align to character with preview" })

    -- Aligns to a string with previews
    vim.keymap.set("x", "aw", function()
      require("align").align_to_string({
        preview = true,
        regex = false,
      })
    end, { desc = "align to word" })

    -- Aligns to a Vim regex with previews
    vim.keymap.set("x", "ar", function()
      require("align").align_to_string({
        preview = true,
        regex = true,
      })
    end, { desc = "align to regex" })
  end,
}
