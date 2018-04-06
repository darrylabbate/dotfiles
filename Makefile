UNAME        := $(shell uname -s)
DOTFILES_DIR := $(shell pwd)

ifeq ($(UNAME), Darwin)
	OS       := 'macos'
endif
ifeq ($(UNAME), Linux)
	OS       := 'linux'
endif

.PHONY: help usage
help: usage

usage:
	@echo ""
	@echo "dotfiles"
	@echo ""
	@echo "Custom macOS settings and terminal configurations"
	@echo ""
	@echo "- Install standard terminal-based configs (suitable for work-issued computers or servers):"
	@echo "    make"
	@echo ""
	@echo "- Install all configs (suitable for personal computers):"
	@echo "    make home"
	@echo ""

.PHONY: all home

all: $(OS) git-init stow

home: all
	source $(DOTFILES_DIR)/macos/home.sh

.PHONY: linux macos

linux:
	source $(DOTFILES_DIR)/linux/apt.sh

macos: bash brew ruby
	xcode-select --install
	chmod +x $(DOTFILES_DIR)/macos/.chunkwmrc
	source $(DOTFILES_DIR)/macos/defaults.sh
	brew services start chunkwm
	brew services start skhd
	stow macos
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	softwareupdate -i -a

.PHONY: bash brew git-init ruby stow

bash: brew
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash

brew:
	source $(DOTFILES_DIR)/macos/brew.sh

git-init: $(OS)
	git submodule init
	git sobmodule update

ruby: brew
	rbenv install 2.5.0
	rbenv global 2.5.0

stow: $(OS)
	stow bash
	stow git
	stow gpg
	stow vim
	source ~/.bash_profile
