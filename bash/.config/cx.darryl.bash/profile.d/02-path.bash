_profile_prepend PATH "$HOME/.local/bin" :
_profile_prepend PKG_CONFIG_PATH "$HOME/.local/lib/pkgconfig" :

# A trailing colon tells man to retain its system-default search path.
case ${MANPATH-} in
    *:) ;;
    '') export MANPATH=: ;;
    *) export MANPATH=$MANPATH: ;;
esac
