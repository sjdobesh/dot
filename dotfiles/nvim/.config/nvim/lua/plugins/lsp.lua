-- lsp stuff
--
-- loads the following
-- - lsp servers
--   - mason package manager
--     - mason.nvim
--     - mason-lspconfig.nvim
--     - mason-nvim-dap.nvim
--   - lua ls management for nvim
--     - lazydev
-- - auto complete
--   - nvim-cmp  # used as source
--   - blink.cmp # main autocomplete engine

local mason_lsps = {
  "bashls",
  "clangd",
  "cmake",
  "fish_lsp",
  "glsl_analyzer",
  "hls",
  "lua_ls",
  "rust_analyzer",
}

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = mason_lsps,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        "LazyVim",
        { path = "${3rd}/love2d/library", words = { "love" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
      },
    },
  },
  { -- source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "cargo +nightly build --release",
    branch = "v1",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<A-k>"] = { "scroll_documentation_up", "fallback" },
        ["<A-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-s>"] = { "show_signature", "hide_signature" },
      },
      appearance = { nerd_font_variant = "mono" },
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        documentation = {
          window = {
            border = "single",
          },
          auto_show = true,
          auto_show_delay_ms = 100,
        },
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
