return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  priority = 10, -- low priority to catch other plugins' keybindings
  config = function()
    require("tiny-glimmer").setup({
      enabled = true,
      overwrite = {
        auto_map = true,
        yank = {
          enabled = true,
          default_animation = {
            name = "left_to_right",
            settings = {
              max_duration = 1000,
              min_duration = 200,
            },
          },
        },
        search = {
          enabled = true,
          default_animation = "left_to_right",
          next_mapping = "n", -- next match
          prev_mapping = "N", -- previous match
        },
        paste = {
          enabled = true,
          default_animation = "reverse_fade",
          paste_mapping = "p", -- after cursor
          Paste_mapping = "P", -- before cursor
        },
        undo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffDelete",
              max_duration = 700,
              min_duration = 700,
            },
          },
          undo_mapping = "u",
        },
        redo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffAdd",
              max_duration = 800,
              min_duration = 800,
            },
          },
          redo_mapping = "<c-r>",
        },
      },
    })

  end
}
