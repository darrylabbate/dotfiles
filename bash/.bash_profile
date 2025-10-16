# TODO modularize (module-fy?) Amazon Q settings
# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.pre.bash"

export INPUTRC=${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc
export GNUPGHOME=${XDG_CONFIG_HOME:-$HOME/.config}/gnupg
source ${XDG_DATA_HOME:-$HOME/.local/share}/cx.darryl.modules/init/bash

export GPG_TTY=$(tty)

[[ $(uname -s) == Linux ]] && ulimit -c unlimited

# Search path for manual pages on macOS is deduced from $PATH
# On Linux, appending a colon to $MANPATH prepends the value to the search path
# See: manpath(1)
if [[ $(uname -s) == Linux ]]; then
    export MANPATH=$HOME/.local/share/man:
fi

# Source bash completions here since the script doesn't run properly within a
# modulefile
[[ -r $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh ]] &&
    . $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bash_profile.post.bash"
