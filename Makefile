DOTFILES_DIR := $(shell echo $(HOME)/dotfiles)
SHELL        := /bin/sh
UNAME        := $(shell uname -s)
USER         := $(shell whoami)

ifeq      ($(UNAME), Darwin)
  OS := macos
else ifeq ($(UNAME), Linux)
  OS := linux
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
	\\n\
	  make link    Symlink only Bash and Vim configurations to the home directory.\\n\
	\\n\
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
	brew services start chunkwm
	brew services start skhd
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	softwareupdate -aiR

link:
	ln -fs $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bash_profile
	ln -fs $(DOTFILES_DIR)/bash/.bashrc $(HOME)/.bashrc
	ln -fs $(DOTFILES_DIR)/bash/.curlrc $(HOME)/.curlrc
	ln -fs $(DOTFILES_DIR)/bash/.inputrc $(HOME)/.inputrc
	ln -fs $(DOTFILES_DIR)/bash/.hushlogin $(HOME)/.hushlogin
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
	echo /usr/local/bin/bash | sudo tee -a /etc/shells
	chsh -s /usr/local/bin/bash

brew:
ifeq ($(UNAME), Darwin)
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle --file=$(DOTFILES_DIR)/macos/.Brewfile
else ifeq ($(UNAME), Linux)
	sudo apt install build-essential
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	/home/linuxbrew/.linuxbrew/bin/brew bundle --file=$(DOTFILES_DIR)/linux/.Brewfile
endif
	brew analytics off

stow:
	stow bash
	stow git
	stow gpg
	stow haskell
	stow vim
