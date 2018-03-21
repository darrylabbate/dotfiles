#!/usr/bin/env bash

sudo -v

softwareupdate -i -a

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew bundle

stow bash
stow vim
stow wm

echo /usr/local/bin/bash >> /etc/shells
chsh -s /usr/local/bin/bash

source ${HOME}/dotfiles/defaults.sh
