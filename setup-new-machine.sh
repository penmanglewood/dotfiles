#!/usr/bin/env bash
#
# setup-new-machine.sh sets up a new machine with the dev tools I use.
#
# Once you have access to git and Github from the new machine, run this.
# It will ask you to confirm before doing anything. 

set -e
set -o pipefail

function setup_bash() {
  if [ -f $HOME/.bash_profile ]
  then
    return
  fi

  cp shell/bash_profile $HOME/.bash_profile
  source $HOME/.bash_profile
}

if [ `whoami` = "root" ]
then
	echo "Run this script as a non-root user."
	echo "The appropriate commands will use sudo."
	exit 1
fi

case `uname` in
	Darwin)
		./setup-new-machine-mac.sh
		;;
	Linux)
		./setup-new-machine-linux.sh
		;;
	*)
		echo "architecture not supported: $(uname)"
		exit 1
		;;
esac

case "$SHELL" in
  /bin/bash)
    setup_bash
    ;;
  *)
    echo "shell $SHELL isn't supported yet"
    ;;
esac

# Configure neovim
mkdir -p ${XDG_DATA_HOME:-$HOME}/.config/nvim
cp nvim/init.vim ${XDG_DATA_HOME:-$HOME}/.config/nvim/init.vim
nvim +PlugInstall +qa

# Configure Go
mkdir -p ${XDG_DATA_HOME:-$HOME}/go
go env -w GO111MODULE="on"
go env -w GOPATH="${XDG_DATA_HOME:-$HOME}/go"
go env -w GOBIN="${XDG_DATA_HOME:-$HOME}/go/bin"
go env -w GOPRIVATE="github.com/penmanglewood/*"
go env -w GONOPROXY="github.com/penmanglewood/*"
go env -w GONOSUMDB="github.com/penmanglewood/*"

# Configure git
if [ ! -f ${XDG_DATA_HOME:-$HOME}/.gitconfig ]
then
  cp ./gitconfig ${XDG_DATA_HOME:-$HOME}/.gitconfig
else
  echo "- base git config already set"
fi

if ! git config --global user.email > /dev/null 2>&1
then
  echo "- configuring git"
  printf "    - enter your git email address: "
  read gitemail
  git config --global user.email "$gitemail"
else
  echo "- git email address already set"
fi

if ! git config --global user.name > /dev/null 2>&1
then
  git config --global user.name "Eric Rubio"
else
  echo "- git name already set"
fi

echo
echo "dotfiles installed."
