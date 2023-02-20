if [[ "$(uname -s)" == "Darwin" ]]; then
    brew_prefix=/opt/homebrew
else
    brew_prefix=/home/linuxbrew/.linuxbrew
fi

if [[ "$(uname -s)" == "Linux" ]]; then
    ulimit -c unlimited
fi

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

if [[ "$(uname -s)" == "Darwin" ]]; then
    PATH=$brew_prefix/opt/coreutils/libexec/gnubin:/usr/local/texlive/2022basic/bin/x86_64-darwin${PATH:+:${PATH}}
elif [[ -d /etc/parallelcluster ]]; then
    PATH=$HOME/.libfabric/install/bin:$HOME/.ompi/install/bin:/usr/local/cuda/bin:/opt/slurm/bin:/opt/amazon/efa/bin:/opt/amazon/openmpi/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=$HOME/.local/lib:$brew_prefix/lib:$HOME/.libfabric/install/lib:$HOME/.ompi/install/lib:/usr/local/cuda/lib64:/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
fi

if [[ -d $brew_prefix ]]; then
    eval "$($brew_prefix/bin/brew shellenv)"
fi

# $HOME/.local should take precedence over Homebrew
export PATH=$HOME/.local/bin${PATH:+:${PATH}}
export MANPATH=$HOME/.local/share/man${MANPATH:+${MANPATH}}

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
