install: brew defaults update

bash:
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash

brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle

defaults:
	source ${HOME}/dotfiles/defaults.sh

update:
	softwareupdate -i -a
