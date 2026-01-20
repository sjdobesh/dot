--    ______    ________  ___
--   / ___/ |  / /  _/  |/  /
--   \__ \| | / // // /|_/ /
--  ___/ /| |/ // // /  / /
-- /____(_)___/___/_/  /_/
--
----------------------------------------------------------------------------(80)

-- OPTIONS -------------------------------------------------------------------80

require("configs.options")

-- KEY MAPS --------------------------------------------------------------------

require("configs.keymaps")

-- PLUGINS ---------------------------------------------------------------------

-- --require("plugins")

local plugins = {

  -- simple configuration plugins
  { "tpope/vim-surround"   },           -- (s)urround command
  { "tpope/vim-commentary" },           -- group comments
  { "tpope/vim-fugitive" },
  { "hedyhli/outline.nvim" },           -- symbol viewer
  { "nvim-tree/nvim-web-devicons"    }, -- icons (common dependency)
  { "ntpeters/vim-better-whitespace" }, -- whitespace management
  { "mbbill/undotree" },
  require("plugins.lualine"),           -- status line and tabs
  require("plugins.oil"),               -- file viewer/editor
  require("plugins.dashboard"),               -- file viewer/editor
  require("plugins.sonokai"),               -- file viewer/editor

--
--   -- -- telescope fzf
--   {
--     "nvim-telescope/telescope.nvim", tag = "v0.2.1",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
--     }
--   },
--   -- lsp
--   { "mason-org/mason-lspconfig.nvim",
--     opts = {
--       ensure_installed = mason_lsps,
--     },
--     dependencies = {
--       { "mason-org/mason.nvim", opts = {} },
--         "neovim/nvim-lspconfig",
--     },
--   },
--
--   {
--     "folke/lazydev.nvim",
--     ft = "lua", -- only load on lua files
--     opts = {
--       library = {
--         -- See the configuration section for more details
--         -- Load luvit types when the `vim.uv` word is found
--         { path = "${3rd}/luv/library", words = { "vim%.uv" } },
--       },
--     },
--   },
--
--   { -- optional cmp completion source for require statements and module annotations
--     "hrsh7th/nvim-cmp",
--     opts = function(_, opts)
--       opts.sources = opts.sources or {}
--       table.insert(opts.sources, {
--         name = "lazydev",
--         group_index = 0, -- set group index to 0 to skip loading LuaLS completions
--       })
--     end,
--   },
--   -- blink
--   {
--     "saghen/blink.cmp",
--     dependencies = { "rafamadriz/friendly-snippets" },
--     version = "1.*",
--     opts = {
--       keymap = {
--         preset = "super-tab",
--         ["<C-k>"] = { "select_prev", "fallback" },
--         ["<C-j>"] = { "select_next", "fallback" },
--         ["<C-s>"] = { "show_signature", "hide_signature" },
--       },
--       appearance = { nerd_font_variant = "mono" },
--       sources = {
--         default = { "lsp", "path", "snippets", "buffer" },
--       },
--       signature = { enabled = true },
--       fuzzy = { implementation = "prefer_rust_with_warning" },
--       completion = {
--         accept = {
--           auto_brackets = {
--             enabled = false,
--           },
--         },
--       },
--     },
--     opts_extend = { "sources.default" }
--   },
--
--
}
-- -- lazy ------------------------------------------------------------------------
--
-- install lazy loader if not available
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup(
  plugins,
  {
    checker = {
      enabled = true, -- automatically check for updates in the background
    },
    install = {
      colorscheme = { "habamax" },
    },
  }
)
--
-- -- plugin settings -------------------------------------------------------------
--
--
-- --
-- require("oil").setup({
--   default_file_explorer = true,
--   columns = {
--     "icon",
--     "permissions",
--     "size",
--   },
--   buf_options = {
--     buflisted = false,
--     bufhidden = "hide",
--   },
--   win_options = {
--     wrap = false,
--     signcolumn = "no",
--     cursorcolumn = false,
--     foldcolumn = "0",
--     spell = false,
--     list = false,
--     conceallevel = 3,
--     concealcursor = "nvic",
--   },
--   delete_to_trash = false,
--   skip_confirm_for_simple_edits = false,
--   prompt_save_on_select_new_entry = true,
--   cleanup_delay_ms = 2000,
--   lsp_file_methods = {
--     enabled = true,
--     timeout_ms = 1000,
--     autosave_changes = false,
--   },
--   constrain_cursor = "editable",
--   watch_for_changes = true,
--   keymaps = {
--     ["g?"] = { "actions.show_help", mode = "n" },
--     ["<CR>"] = "actions.select",
--     ["<A-s>"] = { "actions.select", opts = { vertical = true } },
--     ["<A-f>"] = { "actions.select", opts = { tab = true } },
--     ["<A-p>"] = "actions.preview",
--     ["<A-c>"] = { "actions.close", mode = "n" },
--     ["-"] = { "actions.parent", mode = "n" },
--     ["_"] = { "actions.open_cwd", mode = "n" },
--     ["`"] = { "actions.cd", mode = "n" },
--     ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
--     ["gs"] = { "actions.change_sort", mode = "n" },
--     ["gx"] = "actions.open_external",
--     ["g."] = { "actions.toggle_hidden", mode = "n" },
--     ["g\\"] = { "actions.toggle_trash", mode = "n" },
--     -- ["<A-h>"] = { "actions.select", opts = { horizontal = true } },
--     -- ["<A-l>"] = "actions.refresh",
--   },
--   -- set to false to disable all of the above keymaps
--   use_default_keymaps = true,
--   view_options = {
--     show_hidden = true,
--     -- defines "hidden" file
--     is_hidden_file = function(name, bufnr)
--       local m = name:match("^%.")
--       return m ~= nil
--     end,
--     -- "fast" will turn off sorting for large directories.
--     natural_order = "fast",
--     case_insensitive = false,
--     sort = {
--       -- see :help oil-columns to see which columns are sortable
--       { "type", "asc" },
--       { "name", "asc" },
--     },
--   },
--   git = {
--     add = function(path)
--       return true
--     end,
--     mv = function(src_path, dest_path)
--       return true
--     end,
--     rm = function(path)
--       return true
--     end,
--   },
--   float = {
--     padding = 2,
--     min_width = { 20, 0.25},
--     max = { 20, 0.25},
--     border = nil,
--     preview_split = "left",
--     -- config passed to nvim_open_win.
--     override = function(conf)
--       return conf
--     end,
--   },
--   preview_win = {
--     update_on_cursor_moved = true,
--     preview_method = "fast_scratch",
--     disable_preview = function(filename)
--       return false
--     end,
--   },
--   confirmation = {
--     max_width = 0.9,
--     min_width = { 40, 0.4 },
--     width = nil,
--     max_height = 0.9,
--     min_height = { 5, 0.1 },
--     height = nil,
--     border = nil,
--     win_options = {
--       winblend = 0,
--     },
--   },
--   -- configuration for the floating progress window
--   progress = {
--     max_width = 0.9,
--     min_width = { 40, 0.4 },
--     max_height = { 10, 0.9 },
--     min_height = { 5, 0.1 },
--     minimized_border = "none",
--   },
--   -- configuration for the floating ssh window
--   ssh = {
--     border = nil,
--   },
--   -- configuration for the floating keymaps help window
--   keymaps_help = {
--     border = nil,
--   },
-- })
--
-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'auto',
--     component_separators = { left = '', right = ''},
--     section_separators = { left = '', right = ''},
--     disabled_filetypes = {
--       statusline = {},
--       winbar = {},
--     },
--     ignore_focus = {},
--     always_divide_middle = true,
--     always_show_tabline = true,
--     globalstatus = false,
--     refresh = {
--       statusline = 1000,
--       tabline = 1000,
--       winbar = 1000,
--       refresh_time = 16, -- ~60fps
--       events = {
--         'WinEnter',
--         'BufEnter',
--         'BufWritePost',
--         'SessionLoadPost',
--         'FileChangedShellPost',
--         'VimResized',
--         'Filetype',
--         'CursorMoved',
--         'CursorMovedI',
--         'ModeChanged',
--       },
--     }
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'branch', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {
--     lualine_a = {'buffers'},
--     lualine_x = {},
--     lualine_y = {},
--     lualine_z = {'tabs'}
--   },
--   winbar = {},
--   inactive_winbar = {},
--   extensions = {}
-- }
--
-- require("telescope").setup({
--   pickers = {
--     find_files = {
--       theme = "ivy",
--     },
--     live_grep = {
--       theme = "ivy",
--     },
--   },
-- })
--
-- local tele_builtin = require("telescope.builtin")
-- -- vim.keymap.set({"v", "n"}, "<leader>fs", tele_builtin.grep_string, {})
-- vim.keymap.set({"v", "n"}, "<leader>fs", function() tele_builtin.grep_string({cwd = "~"}) end, {})
-- vim.keymap.set("n", "<leader>fa", tele_builtin.find_files, {})
-- vim.keymap.set("n", "<leader>ff", tele_builtin.git_files, {})
-- vim.keymap.set("n", "<leader>fg", tele_builtin.live_grep, {})
-- vim.keymap.set("n", "<leader>fb", tele_builtin.buffers, {})
-- vim.keymap.set("n", "<leader>fh", tele_builtin.help_tags, {})
--
-- -- lsp config ------------------------------------------------------------------
--
-- -- lsp language
-- local mason_lsps = {
--
--   -- "lua is handled by lazydev"
--   "bashls",
--   "clangd",
--   "pylsp",
--   "rust-analyzer",
-- }
-- -- Ensure mason and mason-lspconfig are set up first
-- require("mason").setup({})
-- require("mason-lspconfig").setup({
--     ensure_installed = mason_lsps,
-- })
