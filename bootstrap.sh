#!/usr/bin/env bash

sudo -v

softwareupdate -i -a

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

rm ~/.bash_profile
ln -s ~/.dotfiles/.bash_profile ~

function createSymlinks() {

}