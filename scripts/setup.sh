#!/bin/bash
install_type=0
i=0
while [[ $install_type != 6 || $install_type != 7 ]];
do
  if [[ i != 0 && ( $install_type -lt 1 || $install_type -gt 7 ) ]]; then
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
  echo "6) complete install and exit"
  echo "7) exit"
  echo "----------------------------------------"
  read -p ":" install_type
  echo "----------------------------------------"


  if [[ $install_type ==  1 || $install_type == 6 ]]; then
    echo "installing apt packages"
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
    )
    cd ~
    sudo apt-get update -y
    for pkg in "${PACKAGES[@]}"; do
      echo "installing $pkg..."
      if dpkg -s "$pkg" 2>&1 | grep "not installed" > /dev/null; then
        sudo apt-get install -y "$pkg"
      else
        echo "$pkg already installed"
      fi
    done
  fi

  if [[ $install_type ==  2 || $install_type == 6 ]]; then
    echo "installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    export PATH=$PATH:$HOME/.cargo/bin
    rustup self update
    rustup update
    echo "downloading cargo crates"
    CRATES=(
      "eza"
      "bat"
      "ripgrep"
    )
    for crate in "${CRATES[@]}"; do
      cargo install $crate
    done

    echo "system upgrade"
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoclean -y
    sudo apt-get autoremove -y


  fi

  if [[ $install_type ==  3 || $install_type == 6 ]]; then
    echo "downloading git repositories"
    REPOS=(
      "https://github.com/sjdobesh/pngz.git"
    )
    mkdir -p ~/repos
    cd ~/repos
    for repo_url in "${REPOS[@]}"; do
      repo_name="$(basename "$repo_url" .git)"
      echo "installing $repo_name with $repo_url"
      if [ ! -d "$repo_name" ] || [ ! -d "$repo_name/.git" ]; then
        git clone "$repo_url"
      else
        echo "found $repo_name, pulling latest changes"
        cd "$repo_name"
        git pull
        cd ..
      fi
    done
    echo "repos downloaded"
  fi

  if [[ $install_type ==  4 || $install_type == 6 ]]; then
    echo "stowing symlinks"
    cd ~/dot/.dotfiles
    stow --no-folding --adopt -vt ~ */
    chsh -s $(which zsh)
    echo "configs stowed"
  fi

  if [[ $install_type ==  5 || $install_type == 6 ]]; then
    echo "installing neovim"
    cd ~
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
  if [[ $install_type == 6 || $install_type ==  7 ]]; then
    count=`ls ~/.ssh -1 *.pub 2>/dev/null | wc -l`
    if [[ $count == 0 ]]; then
      echo "no pub key found, generating new ssh keys"
      ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -N ""
    fi
    echo "ssh pub key :"
    'cat' ~/.ssh/*.pub
    git config --global user.email "samjdobesh@gmail.com"
    git config --global user.name "samantha"
    git -C ~/dot remote set-url origin git@github.com:sjdobesh/dot.git
    exec zsh
  fi
done


