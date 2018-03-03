#!/usr/bin/env bash

sudo -v

softwareupdate -i -a

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew bundle

stow bash
stow vim

source ${HOME}/dotfiles/defaults.sh
