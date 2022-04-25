DOTFILES_DIR := $(shell echo $(HOME)/dotfiles)
SHELL        := /bin/sh
UNAME_M      := $(shell uname -m) # arm64, x86_64, etc
UNAME_S      := $(shell uname -s) # Darwin, Linux, etc
USER         := $(shell whoami)

ifeq ($(UNAME_S), Darwin)
OS           := macos
ifeq ($(UNAME_M), arm64)
BREW_PREFIX  := /opt/homebrew
else ifeq ($(UNAME_M), x86_64)
BREW_PREFIX  := /usr/local
endif
else ifeq ($(UNAME_S), Linux)
OS           := linux
BREW_PREFIX  := /home/linuxbrew/.linuxbrew
endif

.PHONY: all install

all: install

install: $(OS)

.PHONY: help usage
.SILENT: help usage

help: usage

usage:
	printf "\\n\
	\\033[1mDOTFILES\\033[0m\\n\
	\\n\
	Custom settings and configurations for Unix-like environments.\\n\
	See README.md for detailed usage information.\\n\
	\\n\
	\\033[1mUSAGE:\\033[0m make [target]\\n\
	\\n\
	  make         Install all configurations and applications.\\n\
	  make link    Symlink only Bash and Vim configurations to the home directory.\\n\
	  make unlink  Remove symlinks created by \`make link\`.\\n\
	\\n\
	"

.PHONY: linux macos link unlink

linux: brew stow
	stow linux

macos: bash brew stow
	bash $(DOTFILES_DIR)/macos/defaults.sh
	bash $(DOTFILES_DIR)/macos/duti/set.sh
	stow macos
	brew services start yabai
	brew services start skhd
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	softwareupdate -aiR

link:
	ln -fs $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bash_profile
	ln -fs $(DOTFILES_DIR)/bash/.bashrc $(HOME)/.bashrc
	ln -fs $(DOTFILES_DIR)/bash/.curlrc $(HOME)/.curlrc
	ln -fs $(DOTFILES_DIR)/bash/.inputrc $(HOME)/.inputrc
	ln -fs $(DOTFILES_DIR)/bash/.hushlogin $(HOME)/.hushlogin
	ln -fs $(DOTFILES_DIR)/macos/kitty.conf $(HOME)/.config/kitty/kitty.conf
	ln -fs $(DOTFILES_DIR)/vim/.vimrc $(HOME)/.vimrc
	ln -fs $(DOTFILES_DIR)/vim/.vim $(HOME)/.vim

unlink:
	unlink $(HOME)/.bash_profile
	unlink $(HOME)/.bashrc
	unlink $(HOME)/.curlrc
	unlink $(HOME)/.hushlogin
	unlink $(HOME)/.inputrc
	unlink $(HOME)/.vimrc
	unlink $(HOME)/.vim
	@printf "\\033[32m✓\\033[0m Symlinks removed. Manually remove ~/dotfiles directory if needed.\\n"

.PHONY: bash brew stow

bash: brew
	echo $(BREW_PREFIX)/bin/bash | sudo tee -a /etc/shells
	chsh -s $(BREW_PREFIX)/bin/bash

brew:
ifeq ($(UNAME_S), Linux)
	sudo apt install build-essential
endif
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	$(BREW_PREFIX)/bin/brew bundle --file=$(DOTFILES_DIR)/$(OS)/.Brewfile
	brew analytics off

stow:
	stow bash
	stow git
	stow gpg
	stow vim
