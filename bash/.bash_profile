shopt -qs checkwinsize

for file in ~/dotfiles/.*; do
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
