#!/bin/bash
#########################################
# Script to link the dotfiles to their  #
# correct locations in the home dir.    #
# Will not overrite existing files. Use #
# at your own risk.                     #
#########################################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo Scripts are in $DIR

echo "Want to install for windows subsystem for linux? set \$WIN_INSTALL=true"

echo "Cloning submodules"
git submodule init
git submodule update

echo "Linking to .bashrc"
ln -s $DIR/.bashrc ~/.bashrc

echo "Linking to .vimrc"
ln -s $DIR/.vimrc ~/.vimrc

echo "Linking bash aliases"
ln -s $DIR/.bash_aliases ~/.bash_aliases

echo "Linking bash-git-prompt"
ln -s "$DIR/.bash-git-prompt" ~

if [ "$WIN_INSTALL"=true ]; then
        echo "Installing example windows config file"
        ln -s $DIR/.bash_settings_win ~/.bash_settings
fi
