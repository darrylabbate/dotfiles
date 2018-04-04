#!/usr/bin/env bash

# This gives us more control over using the conventional Brewfile mehod

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update, upgrade
brew update
brew upgrade

# Install cask before tapping
brew install cask

# Taps
brew tap homebrew/core
brew tap homebrew/bundle
brew tap homebrew/services
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts
brew tap crisidev/chunkwm
brew tap koekeishiya/formulae

# Upgrade system Bash to 4+
# Makefile will configure default shell
brew install bash

# Unix tools
brew install coreutils
brew install stow
brew install watch

# Install GnuPG
brew install gnupg
brew install pth

# Install our preferred tiling window manager and hotkey daemon
brew install chunkwm
brew install skhd

# Language-specific tools
brew install ghc
brew install python
brew install pip3
brew install rbenv
brew install ruby-build

# Casks
brew cask install etcher
brew cask install iina
brew cask install iterm2
brew cask install openemu
brew cask install font-source-code-pro

# Misc tools
brew install tldr

# Terminal fun
brew install cmatrix
brew install neofetch
brew install speedtest-cli
