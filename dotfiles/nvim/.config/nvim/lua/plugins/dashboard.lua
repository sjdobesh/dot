return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  event = "VimEnter",
  config = function()
    local db = require("dashboard")
    local custom_header = {
      "",
      "",
      "    .x+=:.                           _            .",
      "   z`    ^%                         u            @88>",
      "      .   <k           u.    u.    88Nu.   u.    %8P      ..    .     :",
      "    .@8Ned8\"         x@88k u@88c. '88888.o888c    .     .888: x888  x888.",
      "  .@^%8888\"         ^\"8888\"\"8888\"  ^8888  8888  .@88u  ~`8888~\'888X`?888f`",
      " x88:  `)8b.          8888  888R    8888  8888 \'\'888E`   X888  888X \'888>",
      " 8888N=*8888          8888  888R    8888  8888   888E    X888  888X \'888>",
      "  %8\"    R88          8888  888R    8888  8888   888E    X888  888X \'888>",
      "   @8Wou 9%     .     8888  888R   .8888b.888P   888E    X888  888X \'888>",
      " .888888P`    .@8c   \"*88*\" 8888\"   ^Y8888*\"\"    888&   \"*88%\"\"*88\" \'888!`",
      " `   ^\"F     '%888\"    \"\"   'Y\"       `Y\"        R888\"    `~    \"    `\"`",
      "               ^*                                 \"\"",
      "",
      "",
      "",
      }
    -- config
    local custom_shortcuts = {
      -- open new file
      {
        icon = "  ",
        desc = " new",
        key = "e",
        action = "ene | startinsert",
        group = "DashboardNewFile", -- highlight group
      },

      -- search
      {
        icon = " ⟳ ",
        desc = " recent",
        key = "r",
        action = "lua require('telescope.builtin').oldfiles()",
        group = "DashboardRecentFiles",
      },

      {
        icon = " 󰗚 ",
        desc = " sessions ",
        key = "s",
        action = "Telescope session-lens",
        group = "DashboardRecentFiles",
      },

      {
        icon = "  ",
        desc = " grep",
        key = "g",
        action = "lua require('telescope.builtin').live_grep()",
        group = "DashboardFindText",
      },

      -- config files
      {
        icon = "  ",
        desc = " vimconfig",
        key = "v",
        action = "cd ~/dot/dotfiles/nvim/.config/nvim/ | e ./init.lua | LazyDev ",
        -- action = "lcd %:p:h",
        group = "DashboardConfig",
      },

      {
        icon = "  ",
        desc = " zconfig",
        key = "z",
        action = "cd ~ | e ./.zshrc",
        group = "DashboardConfig",
      },

      {
        icon = "  ",
        desc = " lconfig",
        key = "l",
        action = "lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})",
        group = "DashboardConfig",
      },

      {
        icon = " 󱆃 ",
        desc = " installer ",
        key = "i",
        action = "cd ~/dot | e dotfiles/scripts/bin/setup",
        group = "DashboardConfig",
      },

      {
        icon = " 󰿅 ",
        desc = " quit",
        key = "q",
        action = "qa!",
        group = "DashboardQuit",
      },
    }

    -- display at startup
    local custom_footer = function()
      if package.loaded["lazy"] then
        local stats = require("lazy").stats()
        return { "", "", "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. (math.floor(stats.startuptime * 100 + 0.5) / 100) }
      else
        return { "Press `?` for help" }
      end
    end
    vim.cmd(":DisableWhitespace")
    db.setup({
      theme = "doom", -- "hyper" or "doom"
      config = {
        header = custom_header,
        center = custom_shortcuts,
        footer = custom_footer,
      },
      disable_move = true,
    })
    vim.cmd([[highlight DashboardNewFile guifg=#50fa7b]])
    vim.cmd([[highlight DashboardRecentFiles guifg=#ff79c6]])
    vim.cmd([[highlight DashboardFindText guifg=#bd93f9]])
    vim.cmd([[highlight DashboardConfig guifg=#ffb86c]])
    vim.cmd([[highlight DashboardQuit guifg=#ff5555]])

  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "ntpeters/vim-better-whitespace" },
  }
}
