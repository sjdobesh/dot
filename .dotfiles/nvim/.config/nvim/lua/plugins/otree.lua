return {
  "Eutrius/Otree.nvim",
  lazy = false,
  dependencies = {
    "stevearc/oil.nvim",
  },
  config = function()
    require("Otree").setup({
      show_hidden = true,
      win_size = 20,
      use_default_keymaps = false,
      keymaps = {
        ["<CR>"]  = "actions.select",
        ["l"]     = "actions.select",
        ["h"]     = "actions.close_dir",
        ["<C-c>"] = "actions.close_win",
        ["<C-q>"] = "actions.close_win",
        ["<C-t>"] = "actions.close_win",
        ["-"]     = "actions.goto_parent",
        ["<C-d>"] = "actions.goto_dir",
        ["<M-h>"] = "actions.goto_home_dir",
        ["cd"]    = "actions.change_home_dir",
        ["L"]     = "actions.open_dirs",
        ["H"]     = "actions.close_dirs",
        ["o"]     = "actions.oil_dir",
        ["O"]     = "actions.oil_into_dir",
        ["v"]     = "actions.open_vsplit",
        ["s"]     = "actions.open_split",
        ["."]     = "actions.toggle_hidden",
        ["i"]     = "actions.toggle_ignore",
        ["r"]     = "actions.refresh",
        ["f"]     = "actions.focus_file",
        ["?"]     = "actions.open_help",
      },
    })
  end
}
