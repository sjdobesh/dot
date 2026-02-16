return {

  {
    "folke/lazydev.nvim",
    ft = "lua",
    event = "BufReadPre",
    opts = {
      library = {
        "lazy.nvim",
        "LazyVim",
        { path = "${3rd}/love2d/library", words = { "love" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
      },
      diagnostics = {
        globals = { 'require', 'vim', 'table', 'love' },
        disable = { "lowercase-global" }
      },
      -- disable when a .luarc.json file is found
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },

  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

}
