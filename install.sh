#!/usr/bin/env sh

cp vim/vimrc ~/.vimrc
cp vim/vimrc.plugins ~/.vimrc.plugins
cp vim/phpcs-ruleset.xml ~

if [ ! -d ~/.vim/bundle/vundle -a ! -d ~/.vim/bundle/Vundle.vim ]
then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
else
  vim +PluginUpdate
fi

