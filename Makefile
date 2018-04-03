install: bash brew git-init macos ruby stow update

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

macos: brew
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	chmod +x ~/dotfiles/wm/.chunkwmrc
	source ./macos/defaults.sh
	brew services start chunkwm
	brew services start skhd

ruby: brew
	rbenv install 2.5.0
	rbenv global 2.5.0

stow: brew
	stow bash
	stow git
	stow gpg
	stow vim
	stow wm
	source ~/.bash_profile

update:
	softwareupdate -i -a
