for DOTFILE in `find /Users/darryl/Projects/dotfiles`
do
  [ -f “$DOTFILE” ] && source “$DOTFILE”
done