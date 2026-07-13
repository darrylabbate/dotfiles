f=${HOMEBREW_PREFIX:-/opt/homebrew}/etc/bash_completion.d/aws_bash_completer
[[ -r $f ]] && source "$f"
unset f
