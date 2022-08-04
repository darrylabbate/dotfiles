# Source every file in the /bash/dots subdirectory

if [[ "$(uname -s)" == "Darwin" ]]; then
    export PATH="/usr/local/bin:/opt/homebrew/opt/curl/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/opt/llvm/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/texlive/2019basic/bin/x86_64-darwin"
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /etc/parallelcluster ]]; then
    export PATH="$HOME/libfabric/install/bin:$HOME/ompi/install/bin:$HOME/ucx/install/bin:$HOME/.local/bin:/usr/local/cuda/bin${PATH+:$PATH}"
    export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/lib:$HOME/libfabric/install/lib:$HOME/ompi/install/lib:$HOME/ucx/install/lib:/usr/local/cuda/lib64:/usr/lib64:${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}"
fi

if [[ "$(uname -s)" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

for file in ~/dotfiles/bash/dots/*; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Source ParallelCluster configs after
if [[ -d "/opt/parallelcluster" ]]; then
    source "$HOME/dotfiles/bash/pcluster"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
