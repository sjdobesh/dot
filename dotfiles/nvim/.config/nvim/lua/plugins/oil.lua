return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    default_file_explorer = true,

    oil = "float",

    columns = {
      "icon",
      "permissions",
      "size",
    },

    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },

    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },

    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },

    constrain_cursor = "editable",
    watch_for_changes = true,
    keymaps = {
      ["g?"]    = { "actions.show_help", mode = "n" },
      ["<CR>"]  =   "actions.select",
      ["<A-s>"] = { "actions.select", opts = { vertical = true } },
      ["<A-f>"] = { "actions.select", opts = { tab = true } },
      ["<A-p>"] =   "actions.preview",
      ["<A-c>"] = { "actions.close", mode = "n" },
      ["-"]     = { "actions.parent", mode = "n" },
      ["_"]     = { "actions.open_cwd", mode = "n" },
      ["`"]     = { "actions.cd", mode = "n" },
      ["g~"]    = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"]    = { "actions.change_sort", mode = "n" },
      ["gx"]    =   "actions.open_external",
      ["g."]    = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = {   "actions.toggle_trash", mode = "n" },
      ["<A-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<A-l>"] =   "actions.refresh",
    },

    -- set to false to disable all of the above keymaps
    use_default_keymaps = false,
    view_options = {
      show_hidden = true,
      -- defines "hidden" file
      is_hidden_file = function(name, bufnr)
        local m = name:match("^%.")
        return m ~= nil
      end,
      -- "fast" will turn off sorting for large directories.
      natural_order = "fast",
      case_insensitive = false,
      sort = {
        -- see :help oil-columns to see which columns are sortable
        { "type", "asc" },
        { "name", "asc" },
      },
    },

    git = {
      add = function(path)
        return true
      end,
      mv = function(src_path, dest_path)
        return true
      end,
      rm = function(path)
        return true
      end,
    },

    float = {
      padding = 2,
      min_width = { 20, 0.25},
      max = { 20, 0.25},
      border = nil,
      preview_split = "left",
      -- config passed to nvim_open_win.
      override = function(conf)
        return conf
      end,
    },

    preview_win = {
      update_on_cursor_moved = true,
      preview_method = "fast_scratch",
      disable_preview = function(filename)
        return false
      end,
    },

    confirmation = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = nil,
      win_options = {
        winblend = 0,
      },
    },

    -- configuration for the floating progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      minimized_border = "none",
    },

    -- configuration for the floating ssh window
    ssh = {
      border = nil,
    },

    -- configuration for the floating keymaps help window
    keymaps_help = {
      border = nil,
    },
  },
}
