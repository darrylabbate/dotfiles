#!/usr/bin/env bash

BREW_DIR=$HOME/dotfiles/macos/brew

# Install Homebrew
if ! [[ -x "$(command -v brew)" ]]; then 
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update, upgrade
brew update
brew upgrade

# Taps
while read -r tap; do
  brew tap "$tap"
done <"${BREW_DIR}/taps.txt"

# Packages
while read -r package; do
  brew install "$package"
done <"${BREW_DIR}/packages.txt"

# Casks
while read -r cask; do
  brew cask install "$cask"
done <"${BREW_DIR}/casks.txt"

# Mac App Store apps (mas)
while read -r app; do
  mas install "$app"
done <"${BREW_DIR}/appstore.txt"
