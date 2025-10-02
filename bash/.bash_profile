source ~/dotfiles/bash/init/homebrew
source ~/dotfiles/bash/init/modules

[[ $(uname -s) == Linux ]] && ulimit -c unlimited

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

if [[ $(uname -s) == Darwin ]]; then
    module use ~/dotfiles/macos/modulefiles
    module load coreutils
    module load basictex
fi
