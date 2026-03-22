if status is-interactive
    # aliases

    # command abbreviations
    alias v "nvim"
    alias o "xdg-open"
    alias g "git"
    alias mv "mv -i"
    alias diff "diff --color=auto"
    alias ip "ip -c=auto"
    alias feh "feh -Zx -g 1920x1080 -B black --force-alias --auto-reload"
    alias icat "kitten icat"
    alias video "mpv --profile=sw-fast --vo=kitty --vo-kitty-use-shm=yes --really-quiet"
    alias 80 "echo --------------------------------------------------------------------------------"

    # symlink management
    alias upstow "cd ~/dot/dotfiles/; stow --no-folding -vt ~ */; cd -"
    alias unstow "cd ~/dot/dotfiles/; stow -D --no-folding -vt ~ */; cd -"
    alias restow "unstow; upstow"

    # let me out dear god please let me out
    alias q "exit"
    alias wq "exit"
    alias :q "exit"
    alias :wq "exit"

    # web search
    function ff
        firefox
    end
    function ffsearch
        firefox -search "$argv -ai-none"
    end

    function ref
      switch "$argv[1]"
        case tidal
          firefox "https://tidalcycles.org/docs/reference/cycles"
        case haskell
          firefox "https://www.haskell.org/documentation/"
        case nvim
          firefox "https://neovim.io/doc/user/quickref/"
        case fish
          firefox "https://fishshell.com/docs/current/index.html"
        case lua
          firefox "https://www.lua.org/manual/5.5/"
        case love
          firefox "https://love2d.org/wiki/Main_Page"
        case c
          firefox "https://en.cppreference.com/w/c.html"
        case cpp
          firefox "https://en.cppreference.com/w/cpp.html"
        case '*'
          firefox -search "$argv -ai-none"
        end
    end


    # conditional mappings for rust replacements
    # act as original when piping io but have richer interactive UIs

    # ls replacment
    if type -q eza
        alias l="eza -l -T --level 1"
        alias ls="eza -l -T --level 1"
        alias la="eza -la -T --level 1"
        alias l.="eza -lad -T --level 1 .*"
    end

    # grep replacement
    if type -q rg
        alias grep="rg"
    end

    # cat replacement
    if type -q bat
        alias cat="bat"
    end

    # path
    fish_add_path ~/bin
    fish_add_path ~/bin/neovim/bin
    fish_add_path ~/.cargo/bin

    # settings
    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_greeting

end
