HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=10000
bindkey -v
zstyle :compinstall filename '/home/s/.zshrc'
autoload -Uz compinit
compinit

PS1='%F{blue}%B%~%b%f %F{green}❯%f '

setopt inc_append_history

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

export PATH=$PATH:~/.cargo/bin

alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias mv='mv -i'
alias v='nvim'
alias o='xdg-open'
alias g='git'
alias q="exit"
alias :q="exit"
alias wq="exit"
alias :wq="exit"
alias feh='feh -Zx -g 1920x1080 -B black --force-alias --auto-reload'

# if rust utils are available
if hash bat 2>/dev/null; then
  alias cat='bat'
fi
if hash rg 2>/dev/null; then
  alias grep='rg'
fi
if hash eza 2>/dev/null; then
  alias l="eza -la -T --level 1"
  alias la="eza -la -T --level 1"
  alias ls="eza -l -T --level 1"
fi

precmd () { print -Pn "\e]2;%-3~\a"; }
