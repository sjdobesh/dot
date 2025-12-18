#!/bin/bash
install_type=0
i=0
while [[ $install_type -gt 5 || $install_type -lt 1 ]];
do
	
	if ((i != 0)); then
		echo "invalid selection"
		echo "----------------------------------------"
	else
		echo "-------[environment setup script]-------"
	fi
	((i++))

	echo "please select installation type"
	echo "1) download packages"
	echo "2) download repos"
	echo "3) stowing config files"
	echo "4) build neovim"
	echo "5) complete install (all of the above)"
	echo "----------------------------------------"
	read -p ":" install_type
	echo "----------------------------------------"

done


if [[ $install_type ==  1 || $install_type == 5 ]]; then
	echo "installing packages"
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
		"cargo"
		"ninja-build"
		"gettext"
		"libc6-dev"
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
	echo "system upgrade"
	sudo apt-get update -y
	sudo apt-get upgrade -y
	sudo apt-get autoclean -y
	sudo apt-get autoremove -y

	echo "packages downloaded"
fi

if [[ install_type ==  2 || install_type == 5 ]]; then
	echo "downloading git repositories"
	REPOS=(
		"https://github.com/neovim/neovim.git"
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

if [[ install_type ==  3 || install_type == 5 ]]; then
	echo "stowing symlinks"
	cd ~/dot/.dotfiles
	stow --no-folding --adopt -vt ~ */
	chsh -s $(which zsh)
	echo "configs stowed"
fi

if [[ install_type ==  4 || install_type == 5 ]]; then
	echo "building neovim"
	cd ~/repos/neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	echo "neovim built"
fi
