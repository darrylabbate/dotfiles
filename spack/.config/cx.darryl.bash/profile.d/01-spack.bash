export SPACK_USER_CONFIG_PATH=${XDG_CONFIG_HOME:-$HOME/.config}/spack
export SPACK_USER_CACHE_PATH=${XDG_CACHE_HOME:-$HOME/.cache}/spack

fsx_rootdir=/fsx/$USER
_spack_root=${SPACK_ROOT:-$HOME/spack}

[[ -d "$fsx_rootdir" ]] && {
    export SPACK_USER_CACHE_PATH=$fsx_rootdir/cache/spack
    _spack_root=$fsx_rootdir/spack
}

_spack_setup="$_spack_root/share/spack/setup-env.sh"

# Lazy-load Spack
spack() {
    unset -f spack
    [[ -r $_spack_setup ]] || {
        printf 'spack: setup file not found at %s\n' "$_spack_setup" >&2
        return 127
    }
    . "$_spack_setup"
    spack "$@"
}
