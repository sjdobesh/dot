if status is-interactive
    # aliases

    # command abbreviations
    abbr --add v nvim
    abbr --add o xdg-open
    abbr --add g git
    abbr --add mv "mv -i"
    abbr --add ly lynx
    abbr --add l2 links2
    abbr --add diff "kitten diff"
    abbr --add ip "ip -c=auto"
    abbr --add feh "feh -Zx -g 1920x1080 -B black --force-alias --auto-reload"
    abbr --add icat "kitten icat"
    abbr --add video "mpv --profile=sw-fast --vo=kitty --vo-kitty-use-shm=yes --really-quiet"
    abbr --add cbuild "cmake -S . -B build "

    # symlink management
    alias upstow "cd ~/dot/dotfiles/; stow --no-folding -vt ~ */; cd -"
    alias unstow "cd ~/dot/dotfiles/; stow -D --no-folding -vt ~ */; cd -"
    alias restow "unstow; upstow"

    # let me out dear god please let me out
    alias q exit
    alias wq exit
    alias :q exit
    alias :wq exit

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
                lynx "https://tidalcycles.org/docs/reference/cycles"
            case haskell
                lynx "https://www.haskell.org/documentation/"
            case nvim
                lynx "https://neovim.io/doc/user/quickref/"
            case fish
                lynx "https://fishshell.com/docs/current/index.html"
            case lua
                # lynx "https://www.lua.org/manual/5.5/"
                lynx "~/documents/lua-5.5/doc/contents.html"
            case love
                # lynx "https://love2d.org/wiki/Main_Page"
                lynx "~/public/docmirrors/love2doc/love2d.org/wiki/love.html#Modules"
            case SDL3
                # lynx "https://love2d.org/wiki/Main_Page"
                lynx "~/documents/sdlwiki/SDL3/CategoryAPI.html"
            case SDL3.overview
                # lynx "https://love2d.org/wiki/Main_Page"
                lynx "~/documents/sdlwiki/SDL3/APIByCategory.html"
            case SDL2
                # lynx "https://love2d.org/wiki/Main_Page"
                lynx "~/documents/sdlwiki/SDL3/CategoryAPI.html"
            case SDL2.overview
                # lynx "https://love2d.org/wiki/Main_Page"
                lynx "~/documents/sdlwiki/SDL2/APIByCategory.html"
            case c
                lynx "https://en.cppreference.com/w/c.html"
            case cpp
                lynx "https://en.cppreference.com/w/cpp.html"
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
        alias lsa="eza -l -T --absolute --level 1"
        alias laa="eza -la -T --absolute --level 1"
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
    fish_add_path ~/public/kitty/kitty/launcher/kitty

    # settings
    set -x BROWSER lynx
    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_greeting

    # access vim arrows in insert mode for auto complete
    bind -M insert \ch backward-char
    bind -M insert \cj down-or-search
    bind -M insert \ck up-or-search
    bind -M insert \cl forward-char

end
