#!/usr/bin/env bash
#
# Homebrew master script
# Install & maintain Homebrew on macOS
#
# Author: Darryl Abbate
# https://github.com/rootbeersoup

# Exit quickly if run on something other than macOS
if ! [[ "$(uname -s)" == "Darwin" ]]; then
  printf "\\033[31mERROR:\\033[0m macOS required to use Homebrew\\n"
  exit 1
fi

# Spinner function
spinner() 
{
  local clearln="\\033[2K"
  local spinnerstr="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
  local delay="0.05"
  local task=$1
  local msg=$2

  while :; do
    jobs %1 &> /dev/null
    [[ $? = 0 ]] || {
      printf "${clearln}\\033[32m✓\\033[0m ${task}\\n"
      break
    }
    for (( i=0; i<${#spinnerstr}; i++ )); do
      sleep "${delay}"
      printf "${clearln}${spinnerstr:$i:1} ${task} ${msg}\\r"
    done
  done
}

finish ()
{
  tput cnorm
  exit 0
}

interrupt ()
{
  printf "\\n\\033[31m✗\\033[0m User interrupt; terminating...\\n"
  tput cnorm
  exit 2
}

# Clean up and return 0 exit status
trap finish 0

# Clean up upon user interrupt (CTRL+C)
trap interrupt 2

tput civis

BREW_DIR=$HOME/dotfiles/macos

# Install Homebrew if not already installed
if ! [[ -x "$(command -v brew)" ]]; then 
  printf "Homebrew not found on this system; Installing...\\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Brew Bundle

if ! [[ -f "$BREW_DIR"/Brewfile ]]; then
  printf "\\033[31mERROR:\\033[0m Brewfile not found. Skipping \`brew bundle\`...\\n"
else
  (brew bundle --file="$BREW_DIR"/Brewfile &> /dev/null) &
  spinner "Install any missing packages"
fi

# Update
(brew update &> /dev/null) &
spinner "Update Homebrew formulae"

# Upgrade
(brew upgrade --display-times) &
spinner "Upgrade Homebrew packages"

# Cleanup
(brew cleanup &> /dev/null) &
spinner "Clean up Homebrew formulae"

# Done
printf "🍺  Done\\n"
