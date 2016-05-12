#!/bin/bash
#########################################
# Script to link the dotfiles to their  #
# correct locations in the home dir.    #
# Will not overrite existing files. Use #
# at your own risk.                     #
#########################################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo Scripts are in $DIR

echo Linking to .bashrc
ln -s $DIR/.bashrc ~/.bashrc

echo Linking to .vimrc
ln -s $DIR/.vimrc ~/.vimrc
