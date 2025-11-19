export SPACK_USER_CONFIG_PATH=${XDG_CONFIG_HOME:-$HOME/.config}/spack
export SPACK_USER_CACHE_PATH=${XDG_CACHE_HOME:-$HOME/.cache}/spack

fsx_rootdir=/fsx/$USER
spack=~/spack

[[ -d "$fsx_rootdir" ]] && {
    export SPACK_USER_CACHE_PATH=$fsx_rootdir/cache/spack
    spack_root=$fsx_rootdir/spack
}

. $spack/share/spack/setup-env.sh
