if [[ -n ${HOMEBREW_PREFIX-} ]]; then
    coreutils_libexec=$HOMEBREW_PREFIX/opt/coreutils/libexec
    _profile_prepend PATH "$coreutils_libexec/gnubin" :
    _profile_prepend MANPATH "$coreutils_libexec/gnuman" :
    unset coreutils_libexec
fi

alias l='ls -Fh --color --group-directories-first'
alias la='ls -AFh --color --group-directories-first'
alias ll='ls -AFhlo --color --group-directories-first'
