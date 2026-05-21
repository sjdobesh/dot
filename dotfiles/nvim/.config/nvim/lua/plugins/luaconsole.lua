return {
  "yarospace/lua-console.nvim",
  lazy = true,
  keys = {
    { "`", desc = "Lua-console - toggle" },
    { "<Leader>`", desc = "Lua-console - attach to buffer" },
  },
  opts = {
    buffer = {
      preserve_context = false,
      clear_before_eval = true,
    },
  },
}
