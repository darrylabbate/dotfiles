source ~/.modules/init/bash

export GPG_TTY=$(tty)

[[ $(uname -s) == Linux ]] && ulimit -c unlimited

# Search path for manual pages on macOS is deduced from $PATH
# On Linux, appending a colon to $MANPATH prepends the value to the search path
# See: manpath(1)
if [[ $(uname -s) == Linux ]]; then
    export MANPATH=$HOME/.local/share/man:
fi
