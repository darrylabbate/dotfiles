install: bash brew git-init macos stow update

bash: brew
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash

brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle

git-init:
	xcode-select --install
	git submodule init
	git sobmodule update

macos:
	source ./macos/defaults.sh

stow: brew
	stow bash
	stow vim
	stow wm
	source ~/.bash_profile

update:
	softwareupdate -i -a
