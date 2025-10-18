file=${HOMEBREW_PREFIX:-/opt/homebrew}/etc/profile.d/bash_completion.sh

[[ -r $file ]] && source $file

unset file
