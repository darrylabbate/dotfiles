DOTFILES_DIR := $(shell echo $(HOME)/dotfiles)
SHELL        := /bin/sh
UNAME_M      := $(shell uname -m)
UNAME_S      := $(shell uname -s)
USER         := $(shell whoami)

ifeq ($(UNAME_S), Darwin)
BASE         := macos
BREWFILE     := macos/.Brewfile
ifeq ($(UNAME_M), arm64)
BREW_PREFIX  := /opt/homebrew
else ifeq ($(UNAME_M), x86_64)
BREW_PREFIX  := /usr/local
endif

# ParallelCluster
else ifneq ($(shell uname -r | egrep "amzn2"),)
BASE         := pcluster
BREW_PREFIX  := /home/ec2-user/.linuxbrew
BREWFILE     := linux/pcluster.brewfile
else ifeq ($(UNAME_S), Linux)
BASE         := linux
BREW_PREFIX  := /home/linuxbrew/.linuxbrew
BREWFILE     := linux/.Brewfile
endif

.PHONY: all install

all: install

install: $(BASE)
	@printf "Installation complete. If Vim was setup, make sure to run `:PlugInstall`\\n"

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

.PHONY: linux macos pcluster link unlink

linux: brew stow
	$(BREW_PREFIX)/bin/stow linux
	sudo apt install build-essential

macos: brew stow
	bash $(DOTFILES_DIR)/macos/defaults.sh
	bash $(DOTFILES_DIR)/macos/duti/set.sh
	$(BREW_PREFIX)/bin/stow gpg
	$(BREW_PREFIX)/bin/stow macos
	$(BREW_PREFIX)/bin/brew services start yabai
	$(BREW_PREFIX)/bin/brew services start skhd
	echo $(BREW_PREFIX)/bin/bash | sudo tee -a /etc/shells
	chsh -s $(BREW_PREFIX)/bin/bash
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	softwareupdate -aiR

pcluster: brew stow
	sudo yum groupinstall 'Developer Tools'

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

.PHONY: brew stow

brew:
ifeq ($(shell which brew),)
	@printf "Homebrew not detected; running install script\\n"
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@printf "Homebrew already installed; skipping installation\\n"
endif
	$(BREW_PREFIX)/bin/brew bundle --file=$(DOTFILES_DIR)/$(BREWFILE)
	$(BREW_PREFIX)/bin/brew analytics off

stow:
	$(BREW_PREFIX)/bin/stow bash
	$(BREW_PREFIX)/bin/stow git
	$(BREW_PREFIX)/bin/stow vim
