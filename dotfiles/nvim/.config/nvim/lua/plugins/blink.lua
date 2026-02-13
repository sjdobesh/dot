-- blink
return  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = 'cargo +nightly build --release',
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
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
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
      },
    },
    opts_extend = { "sources.default" }
  }
