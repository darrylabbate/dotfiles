DOTFILES_DIR := $(shell echo $(HOME)/dotfiles)
SHELL        := /bin/bash
UNAME        := $(shell uname -s)

ifeq ($(UNAME), Darwin)
  OS         := macos
else ifeq ($(UNAME), Linux)
  OS         := linux
endif

.PHONY: all

all: $(OS)

.PHONY: help usage

help: usage

usage:
	@printf "\\n\
	\\033[1mDOTFILES\\033[0m\\n\
	\\n\
	Custom macOS settings and terminal configurations.\\n\
	See README.md for detailed usage information.\\n\
	\\n\
	\\033[1mUSAGE:\\033[0m make [target]\\n\
	\\n\
	  make         Install all configurations and applications.\\n\
	\\n\
	  make lite    Symlink only Bash and Vim configurations to the home directory.\\n\
	\\n\
	"

.PHONY: linux macos lite

linux: apt git-init ruby-linux stow
	. $(HOME)/.bash_profile

macos: bash brew git-init ruby-macos stow
	bash $(DOTFILES_DIR)/macos/defaults.sh
	bash $(DOTFILES_DIR)/macos/duti/set.sh
	stow macos
	brew services start chunkwm
	brew services start skhd
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	. $(HOME)/.bash_profile
	softwareupdate -aiR

lite: git-init
	ln -fs $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bash_profile
	ln -fs $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bashrc
	ln -fs $(DOTFILES_DIR)/vim/.vimrc $(HOME)/.vimrc
	ln -fs $(DOTFILES_DIR)/vim/.vim $(HOME)/.vim

.PHONY: apt bash brew git-init ruby-linux ruby-macos stow

apt:
	bash $(DOTFILES_DIR)/linux/apt.sh

bash: brew
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash

brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle --file=$(DOTFILES_DIR)/macos/.Brewfile

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
