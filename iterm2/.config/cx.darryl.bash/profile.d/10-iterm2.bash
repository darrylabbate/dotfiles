file=${XDG_DATA_HOME:-$HOME/.local/share}/iterm2/shell_integration.bash

[[ -e $file ]] && source $file

unset file
