source ~/.modules/init/bash

export BASH_SILENCE_DEPRECATION_WARNING=1
export GPG_TTY=$(tty)

alias l="ls -F"
alias la="ls -AF"
alias ll="ls -AFlo"
alias rebash="source ~/.bash_profile"

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

module load brew/shellenv
module load brew/completions
module load vim

if [[ $(uname -s) == Darwin ]]; then
    module use ~/.modules/modulefiles/macOS
    module load skhd
    module load yabai
    module load coreutils
fi

module load shell/nav

module load bash/builtins
module load bash/color
module load bash/prompt
module load bash/history

# module use ~/.modules/modulefiles/Git
