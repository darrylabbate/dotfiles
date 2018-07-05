DOTFILES_DIR := $(shell pwd)
UNAME        := $(shell uname -s)

ifeq ($(UNAME), Darwin)
OS           := macos
endif
ifeq ($(UNAME), Linux)
OS           := linux
endif

.PHONY: all home

all: $(OS)

home: all
	bash $(DOTFILES_DIR)/macos/home.sh

.PHONY: help usage

help: usage

usage:
	@printf "\n\033[1mDOTFILES\033[0m\n"
	@printf "\nCustom macOS settings and terminal configurations"
	@printf "\nSee README.md for detailed information\n"
	@printf "\n\033[1mUSAGE:\033[0m\n"
	@printf "\n  make            Install standard configurations and applications."
	@printf "\n                  Suitable for work-issued computers or servers.\n"
	@printf "\n  make home       Install all configurations and applications."
	@printf "\n                  Suitable for personal computers.\n\n"

.PHONY: linux macos

linux: apt git-init ruby-linux stow
	bash ~/.bash_profile

macos: bash brew git-init ruby-macos stow
	chmod +x $(DOTFILES_DIR)/macos/.chunkwmrc
	bash $(DOTFILES_DIR)/macos/defaults.sh
	bash $(DOTFILES_DIR)/macos/fonts.sh
	stow macos
	brew services start chunkwm
	brew services start skhd
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	bash ~/.bash_profile
	softwareupdate -aiR

.PHONY: apt bash brew git-init ruby-linux ruby-macos stow

apt:
	bash $(DOTFILES_DIR)/linux/apt.sh

bash: brew
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash

brew:
	bash $(DOTFILES_DIR)/macos/brew.sh

git-init:
	git submodule init
	git sobmodule update

ruby-linux: apt
	git clone git://github.com/sstephenson/rbenv.git .rbenv
	git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	rbenv install 2.5.0
	rbenv global 2.5.0

ruby-macos: brew
	rbenv install 2.5.0
	rbenv global 2.5.0

stow:
	stow bash
	stow git
	stow gpg
	stow haskell
	stow vim
