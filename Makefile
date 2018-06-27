UNAME        := $(shell uname -s)
DOTFILES_DIR := $(shell pwd)

ifeq ($(UNAME), Darwin)
OS           := macos
endif
ifeq ($(UNAME), Linux)
OS           := linux
endif

.PHONY: all home

all: $(OS)

home: all
	source $(DOTFILES_DIR)/macos/home.sh

.PHONY: help usage

help: usage

usage:
	@echo ""
	@echo "━━━ dotfiles ━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "Custom macOS settings and terminal configurations"
	@echo "See README.md for detailed information"
	@echo ""
	@echo "    make            Install standard configurations and applications."
	@echo "                    Suitable for work-issued computers or servers."
	@echo ""
	@echo "    make home       Install all configurations and applications."
	@echo "                    Suitable for personal computers."
	@echo ""

.PHONY: linux macos

linux: apt git-init ruby-linux stow
	source ~/.bash_profile

macos: bash brew git-init ruby-macos stow
	chmod +x $(DOTFILES_DIR)/macos/.chunkwmrc
	source $(DOTFILES_DIR)/macos/defaults.sh
	source $(DOTFILES_DIR)/macos/fonts.sh
	stow macos
	brew services start chunkwm
	brew services start skhd
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	source ~/.bash_profile
	softwareupdate -aiR

.PHONY: apt bash brew git-init ruby-linux ruby-macos stow

apt:
	source $(DOTFILES_DIR)/linux/apt.sh

bash: brew
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash

brew:
	source $(DOTFILES_DIR)/macos/brew.sh

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
