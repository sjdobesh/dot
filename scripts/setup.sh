#!/bin/bash

PACKAGES=(
	"git"
	"curl"
	"vim"
	"build-essential"
	"cmake"
	"gdb"
	"zsh"
	"stow"
	"ninja-build"
	"gettext"
	"libc6-dev"
)

echo "updating packages"
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
echo "system upgrade"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoclean -y
sudo apt-get autoremove -y

echo "finished package downloads"

echo "downloading git repositories"
REPOS=(
	"https://github.com/neovim/neovim.git"
	"https://github.com/sjdobesh/pngz.git"
)
mkdir -p repos
cd repos
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

echo "stowing symlinks"
cd ~/dot/.dotfiles
stow --no-folding --adopt -vt ~ */

# echo "building neovim"
# cd ~/repos/neovim
# cmake -DCMAKE_PREFIX_PATH="/usr/bin" .
# make CMAKE_BUILD_TYPE=RelWithDebInfo
# sudo make install


