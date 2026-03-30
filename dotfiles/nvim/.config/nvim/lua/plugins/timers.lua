return {
  "ravsii/timers.nvim",
  version = "0.4.2", -- use latest stable release
  keys = {
    { "<leader>tt", ":TimersDashboard<cr>" },
    { "<leader>tn", ":TimersNew<cr>" },
  },
  opts = {
    persistent = true,
  },
}
