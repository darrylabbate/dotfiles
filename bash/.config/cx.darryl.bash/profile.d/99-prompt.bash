prompt-pwd() {
    local pwd

    case ${1:-basename} in
        basename) pwd='\W ' ;;
        full)     pwd='\w ' ;;
        none)     pwd= ;;
        *)
            printf 'usage: prompt-pwd {basename|full|none}\n' >&2
            return 2
            ;;
    esac

    PS1="$pwd"'\[$(tput -T xterm-256color bold)\]\$\[$(tput -T xterm-256color sgr0)\] '
    export PS1
}

if [[ ${TERM_PROGRAM-} == iTerm.app ]]; then
    prompt-pwd none
else
    prompt-pwd basename
fi
