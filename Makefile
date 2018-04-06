.PHONY: install install-home home git-init macos ruby stow

install: git-init macos ruby stow

install-home: install home

home: macos
	source ./macos/home.sh

git-init:
	git submodule init
	git sobmodule update

macos:
	xcode-select --install
	source ./macos/brew.sh
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash
	chmod +x ~/dotfiles/macos/.chunkwmrc
	source ./macos/defaults.sh
	brew services start chunkwm
	brew services start skhd
	stow macos
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	softwareupdate -i -a

ruby:
	rbenv install 2.5.0
	rbenv global 2.5.0

stow:
	stow bash
	stow git
	stow gpg
	stow vim
	source ~/.bash_profile
