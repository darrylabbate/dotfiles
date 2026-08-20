case "$(uname -s):$(uname -m)" in
    Darwin:arm64)  brew_prefix=/opt/homebrew ;;
    Darwin:x86_64) brew_prefix=/usr/local ;;
    Linux:*)       brew_prefix=$HOME/linuxbrew/.linuxbrew ;;
    *)             brew_prefix= ;;
esac

if [[ -n $brew_prefix && -x $brew_prefix/bin/brew ]]; then
    eval "$("$brew_prefix/bin/brew" shellenv)"
fi

export HOMEBREW_BUNDLE_FILE=$XDG_DATA_HOME/homebrew/Brewfile
export HOMEBREW_CURLRC=$XDG_CONFIG_HOME/curlrc
export HOMEBREW_FORCE_BREWED_CURL=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ASK=1
export HOMEBREW_NO_REQUIRE_TAP_TRUST=1

unset brew_prefix
