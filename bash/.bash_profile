# Source every file in the /bash/dots subdirectory

if [[ "$(uname -s)" == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/opt/llvm/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/texlive/2019basic/bin/x86_64-darwin"
elif [[ "$(uname -s)" == "Linux" && ! -d "/opt/parallelcluster" ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

for file in ~/dotfiles/bash/dots/*; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Source ParallelCluster configs after
if [[ -d "/opt/parallelcluster" ]]; then
    source "/home/ec2-user/dotfiles/bash/pcluster"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
