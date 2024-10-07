case $(uname -s) in
Darwin) brew_prefix=/opt/homebrew              ;;
Linux)  brew_prefix=/home/linuxbrew/.linuxbrew ;;
esac

[[ $(uname -s) == Linux ]] && ulimit -c unlimited

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

if [[ $(uname -s) == Darwin ]]; then
    PATH=$brew_prefix/opt/coreutils/libexec/gnubin:/usr/local/texlive/2024basic/bin/universal-darwin${PATH:+:$PATH}
fi

[[ -d $brew_prefix ]] && eval "$($brew_prefix/bin/brew shellenv)"

export PATH=$HOME/.local/bin${PATH:+:$PATH}

# Search path for manual pages on macOS is deduced from $PATH
# On Linux, appending a colon to $MANPATH prepends the value to the search path
# See: manpath(1)
if [[ $(uname -s) == Linux ]]; then
    export MANPATH=$HOME/.local/share/man:
fi

for file in \
    $HOME/dotfiles/bash/dots/* \
    $HOME/.aocrc \
    $HOME/.iterm_shell_integration.bash
do
    [[ -r $file ]] && [[ -f $file ]] && source $file
done
unset file
