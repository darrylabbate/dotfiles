source ~/.modules/init/bash

export BASH_SILENCE_DEPRECATION_WARNING=1
export GPG_TTY=$(tty)

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
    $HOME/.iterm_shell_integration.bash
do
    [[ -r $file ]] && [[ -f $file ]] && source $file
done
unset file

module load homebrew
module load vim

if [[ $(uname -s) == Darwin ]]; then
    module use ~/.modules/modulefiles/macOS
    module load skhd
    module load yabai
    module load coreutils
fi

module use ~/.modules/modulefiles/bash
module load builtins
module load color
module load nav
module load prompt
module load history

# module use ~/.modules/modulefiles/Git
