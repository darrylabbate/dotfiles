# Disable CWD in prompt if we're in iTerm2; assume status bar has CWD
if {[is-loaded iterm2]} {
    module switch bash/prompt pwd=none
}
