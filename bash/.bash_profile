if [[ "$(uname -s)" == "Darwin" ]]; then
    BREW_PREFIX=/opt/homebrew
else
    BREW_PREFIX=/home/linuxbrew/.linuxbrew
fi

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

if [[ "$(uname -s)" == "Darwin" ]]; then
    PATH=$BREW_PREFIX/opt/coreutils/libexec/gnubin:/usr/local/texlive/2022basic/bin/x86_64-darwin:$PATH
elif [[ -d /etc/parallelcluster ]]; then
    PATH=$HOME/libfabric/install/bin:$HOME/ompi/install/bin:/usr/local/cuda/bin:$PATH
    export LD_LIBRARY_PATH="$HOME/.local/lib:$BREW_PREFIX/lib:$HOME/libfabric/install/lib:$HOME/ompi/install/lib:/usr/local/cuda/lib64:/usr/lib64:${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}"
fi

if [[ -d $BREW_PREFIX ]]; then
    eval "$($BREW_PREFIX/bin/brew shellenv)"
fi

# $HOME/.local/bin should take precedence over Homebrew
export PATH=$HOME/.local/bin:$PATH

# Source every file in the /bash/dots subdirectory
for file in ~/dotfiles/bash/dots/*; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# AOC session cookie
if [[ -f "$HOME/.aocrc" ]]; then
    source $HOME/.aocrc
fi

# Source ParallelCluster configs after
if [[ -d "/opt/parallelcluster" ]]; then
    source $HOME/dotfiles/bash/pcluster
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
