# Source every file in the /bash/dots subdirectory

if [[ "$(uname -s)" == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/local/opt/curl/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/opt/llvm/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/texlive/2019basic/bin/x86_64-darwin"
# Dumb hack for ParallelCluster on EC2
elif [[ "$(uname -r)" =~ "amzn2" ]]; then
    export PATH="/home/ec2-user/.linuxbrew/bin:$PATH"
elif [[ "$(uname -s)" == "Linux" ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

for file in ~/dotfiles/bash/dots/*; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
