return {
  "ravsii/timers.nvim",
  version = "0.4.2", -- use latest stable release
  event = "VimEnter",
  opts = {
    persistent = true,
  },
  -- stylua: ignore
  keys = {
    { "<leader>ta", function() require("timers.ui").active_timers() end, desc = "active timers"     },
    { "<leader>tt", function() require("timers.ui").dashboard()     end, desc = "dashboard"         },
    { "<leader>tn", function() require("timers.ui").create_timer()  end, desc = "new timer"         },
    { "<leader>t!", function() require("timers.ui").cancel()        end, desc = "cancel a timer"    },
    { "<leader>tu", function() require("timers.ui").resume()        end, desc = "resume a timer"    },
    { "<leader>tp", function() require("timers.ui").pause()         end, desc = "pause a timer"     },
  },
}
