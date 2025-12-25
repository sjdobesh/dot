#!/bin/bash
https_prefix="https://github.com/"
ssh_prefix="git@github.com:"
git_email="samjdobesh@gmail.com"
git_name="samantha"
PACKAGES=(
  "git"
  "ssh"
  "curl"
  "vim"
  "build-essential"
  "cmake"
  "gdb"
  "zsh"
  "stow"
  "fuse"
  "python3"
  "libpng-dev"
  "feh"
)
REPOS=(
  "sjdobesh/pngz.git"
  "sjdobesh/pxl.git"
)
CRATES=(
  "eza"
  "bat"
  "ripgrep"
)

install_type=0
i=0
while [[ $install_type != 7 || $install_type != 8 ]];
do
  if [[ i != 0 && ( $install_type -lt 1 || $install_type -gt 8 ) ]]; then
    echo "invalid selection"
    echo "----------------------------------------"
  else
    echo "-------[environment setup script]-------"
  fi
  ((i++))
  echo "please select installation type"
  echo "1) install apt packages"
  echo "2) install rust"
  echo "3) download repos"
  echo "4) stowing config files"
  echo "5) install neovim"
  echo "6) ssh keygen"
  echo "7) complete install and exit"
  echo "8) exit"
  echo "----------------------------------------"
  read -p ":" install_type
  echo "----------------------------------------"

  # apt packages
  if [[ $install_type ==  1 || $install_type == 7 ]]; then
    echo "installing apt packages"
    sudo apt-get update -y
    for pkg in "${PACKAGES[@]}"; do
      echo "installing $pkg..."
      if dpkg -s "$pkg" 2>&1 | grep "not installed" > /dev/null; then
        sudo apt-get install -y "$pkg"
      else
        echo "$pkg already installed"
      fi
    done
    echo "system upgrade"
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoclean -y
    sudo apt-get autoremove -y
  fi

  # rust and cargo packages
  if [[ $install_type ==  2 || $install_type == 7 ]]; then
    echo "installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    export PATH=$PATH:$HOME/.cargo/bin
    rustup self update
    rustup update
    echo "downloading cargo crates"
    for crate in "${CRATES[@]}"; do
      cargo install $crate
    done
  fi

  # download git repos
  if [[ $install_type ==  3 || $install_type == 7 ]]; then
    echo "downloading git repositories"
    mkdir -p ~/repos
    for repo_url in "${REPOS[@]}"; do
      repo_name="$(basename "$repo_url" .git)"
      echo "installing $repo_name with $repo_url"
      if [[ ! -d $repo_name ]]; then
        git -C ~/repos clone "$https_prefix$repo_url"
      else
        echo "found $repo_name, pulling latest changes"
        git -C ~/repos/$repo_name pull
      fi
    done
    echo "repos downloaded"
  fi

  # stow config file symlinks
  if [[ $install_type ==  4 || $install_type == 7 ]]; then
    echo "stowing symlinks"
    stow --no-folding --adopt -vt ~ ~/dot/.dotfiles/*/
    chsh -s $(which zsh)
    echo "configs stowed"
  fi

  # installing neovim
  if [[ $install_type ==  5 || $install_type == 7 ]]; then
    echo "installing neovim"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    sudo mkdir -p /usr/local/bin
    sudo mv ./nvim-linux-x86_64.appimage /usr/local/bin/nvim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo "neovim installed to /usr/local/bin"
    . $HOME/.bashrc
    nvim --headless -c "PlugInstall" -c "qa"
  fi

  # checking for ssh key and git origins
  if [[ $install_type == 6 || $install_type ==  7 ]]; then
    count=`ls ~/.ssh -1 *.pub 2>/dev/null | wc -l`
    if [[ $count == 0 ]]; then
      echo "no pub key found, generating new ssh keys"
      ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -N ""
    else
      echo "found ssh key"
    fi
    echo "setting git config user to $git_name at $git_email"
    git config --global user.email "samjdobesh@gmail.com"
    git config --global user.name "samantha"
    for repo_url in "${REPOS[@]}"; do
      repo_name="$(basename "$repo_url" .git)"
      echo "swapping $repo_name to ssh origin"
      if [[ -d ~/repos/$repo_name ]]; then
        git -C ~/repos/$repo_name remote set-url origin $ssh_prefix$repo_url
      else
        echo "couldn't find $repo_name"
      fi
    done
    echo "remote origins set"
    echo "ssh pub key :"
    'cat' ~/.ssh/*.pub
  fi

  # exit and launch new shell
  if [[ $install_type == 7 || $install_type ==  8 ]]; then
    exec zsh
  fi

done
