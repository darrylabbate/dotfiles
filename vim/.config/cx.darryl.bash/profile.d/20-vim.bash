alias v='vim'

vt() {
    local tag=$1
    shift
    vim -t "$tag" -c 'normal! zz' "$@"
}

export EDITOR=vim
