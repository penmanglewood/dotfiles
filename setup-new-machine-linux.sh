#!/usr/bin/env bash

set -e
set -o pipefail

function setup_with_pacman() {
	sudo pacman -Su

	# Needed by makepkg and wasn't installed by default on manjaro
	if ! pacman -Qi fakeroot > /dev/null 2>&1
  then
    sudo pacman -Sy fakeroot 
  fi

	if ! pacman -Qi neovim > /dev/null 2>&1
	then
		sudo pacman -Sy neovim
	else
		echo "- neovim already installed"
	fi

	# As per instructions on https://github.com/junegunn/vim-plug
	vimplug_loc="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
	if [ ! -f $vimplug_loc ]
	then
		curl -fLo $vimplug_loc \
			--create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		echo "- vim-plug already installed. upgrade with: nvim +PlugUpgrade +qa"
	fi

	if ! pacman -Qi keepassxc > /dev/null 2>&1
	then
		sudo pacman -Sy keepassxc
	else
		echo "- keepassxc already installed"
	fi

	if ! pacman -Qi authy > /dev/null 2>&1
	then
		pushd `mktemp -d`
		git clone https://aur.archlinux.org/authy.git
		pushd authy
		makepkg -s
		sudo pacman -U authy-*.tar.xz
		popd
		popd
	else
		echo "- authy already installed"
	fi

	if ! pacman -Qi go > /dev/null 2>&1
	then
		sudo pacman -Sy go
	else
		echo "- go already installed"
	fi
}

if command -v pacman > /dev/null 2>&1
then
	setup_with_pacman
else
	echo "your package manager is not supported yet"
fi
