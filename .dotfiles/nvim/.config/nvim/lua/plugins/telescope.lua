return {
  { "zane-/cder.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function ()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "descending",
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
            layout_config = {
              height = 0.4,
              width = 0.4,
              prompt_position = "top",
              preview_cutoff = 0,
            },
            layout_strategy = "center",
          }
        },
        extensions = {
          cder = {
            dir_command = {
              'fd ',
              '-L ',
              '--hidden ',
              '--type=d ',
              '. ',
              os.getenv('HOME')
            },
            previewer_command =
              'eza '..
              '-a '..
              '--color=always '..
              '-T '..
              '--level=3 '..
              '--icons '..
              '--git-ignore '..
              '--long '..
              '--no-permissions '..
              '--no-user '..
              '--no-filesize '..
              '--git '..
              '--ignore-glob=.git',
            entry_maker = function(line)
              return {
                value = line,
                display = function(entry)
                  return ' ' .. line:gsub(os.getenv('HOME') .. '/', ''), { { { 1, 3 }, 'Directory' } }
                end,
                ordinal = line,
              }
            end,
          },
        },
      })
      require("telescope").load_extension("cder")
    end
  }
}
