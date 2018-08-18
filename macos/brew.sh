#!/usr/bin/env bash

# Exit if run on something other than macOS
if ! [[ "$(uname -s)" == "Darwin" ]]; then
  printf "\\033[31mERROR:\\033[0m macOS required to use Homebrew\\n"
  exit 1
fi

BREW_DIR=$HOME/dotfiles/macos

# Install Homebrew if not already installed
if ! [[ -x "$(command -v brew)" ]]; then 
  printf "Homebrew not found on this system; Installing...\\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Brew bundle
printf "Checking Brewfile for missing packages...\\n"
brew bundle --file="$BREW_DIR"/Brewfile &> /dev/null

# Update, upgrade, cleanup
printf "Updating Homebrew formulae...\\n"
brew update &> /dev/null
printf "Upgrading Homebrew packages...\\n"
brew upgrade --display-times
printf "Cleaning up Homebrew formulae...\\n"
brew cleanup &> /dev/null
