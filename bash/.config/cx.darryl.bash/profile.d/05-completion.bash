# Load bash completion for tools that only ship a `<tool> completion bash`
# style generator (Cobra/Click CLIs). The generated script both defines its
# helper functions and calls `complete`, which the modulefile `source-sh`
# path captures via a before/after function diff -- that diff intermittently
# drops a helper function, breaking completion in freshly-spawned panes.
# Generating once, caching, and sourcing the file directly is deterministic
# and avoids a subprocess per shell.
_load_completion() {
    local key=$1; shift
    local src; src=$(command -v "$1") || return 0
    local cache=${XDG_CACHE_HOME:-$HOME/.cache}/cx.darryl.bash/completions/$key
    # Regenerate when the cache is missing or older than the tool binary.
    if [[ ! -f $cache || $src -nt $cache ]]; then
        mkdir -p "${cache%/*}"
        if "$@" > "$cache.tmp" 2>/dev/null; then
            mv "$cache.tmp" "$cache"
        else
            rm -f "$cache.tmp"
            return 0
        fi
    fi
    source "$cache"
}
