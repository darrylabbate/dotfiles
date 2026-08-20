file=${XDG_DATA_HOME:-$HOME/.local/share}/iterm2/shell_integration.bash

iterm2_print_user_vars() {
    local committer
    committer=$(git var GIT_COMMITTER_IDENT | sed 's/.*<\([^>]*\)>.*/\1/')
    iterm2_set_user_var gitCommitter "$committer"
}

[[ -e $file ]] && source "$file"

unset file
