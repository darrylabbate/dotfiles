export INPUTRC=${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc
export GNUPGHOME=${XDG_CONFIG_HOME:-$HOME/.config}/gnupg

# Source bash completions here since the script doesn't run properly within a
# modulefile
[[ -r ${HOMEBREW_PREFIX:-/opt/homebrew}/etc/profile.d/bash_completion.sh ]] &&
    . ${HOMEBREW_PREFIX:-/opt/homebrew}/etc/profile.d/bash_completion.sh

# Can't get this to work as a module either
[[ -e ${XDG_DATA_HOME:-$HOME/.local/share}/iterm2/shell_integration.bash ]] &&
    source ${XDG_DATA_HOME:-$HOME/.local/share}/iterm2/shell_integration.bash

source ${XDG_DATA_HOME:-$HOME/.local/share}/cx.darryl.modules/init/bash

export GPG_TTY=$(tty)

[[ $(uname -s) == Linux ]] &&
    ulimit -c unlimited

# Search path for manual pages on macOS is deduced from $PATH
# On Linux, appending a colon to $MANPATH prepends the value to the search path
# See: manpath(1)
[[ $(uname -s) == Linux ]] &&
    export MANPATH=${XDG_DATA_HOME:-HOME/.local/share}/man:
