if status is-interactive
    alias v "nvim"
    alias o "xdg-open"
    alias g "git"
    alias mv "mv -i"
    alias diff "diff --color=auto"
    alias ip "ip -c=auto"
    alias feh "feh -Zx -g 1920x1080 -B black --force-alias --auto-reload"
    alias icat "kitten icat"
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
    function ff
        firefox -search "$argv -ai-none"
    end
    set -g fish_key_bindings fish_vi_key_bindings
    if type -q eza
        alias l="eza -l -T --level 1"
        alias ls="eza -l -T --level 1"
        alias la="eza -la -T --level 1"
        alias la="eza -la -T --level 1"
        alias l.="eza -lad -T --level 1 .*"
    end
    if type -q rg
        alias grep="rg"
    end
    if type -q bat
        alias cat="bat"
    end
end
