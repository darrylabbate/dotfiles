#!/usr/bin/env bash

# Ensure exactly one yabai daemon runs, via the com.asmvik.yabai LaunchAgent.
# Removes stale agents left by older installs (pre-rename label, brew services)
# and kills stray processes. Safe to re-run.

set -euo pipefail

label=com.asmvik.yabai
stale_labels=(
    com.koekeishiya.yabai
    homebrew.mxcl.yabai
)
agents_dir=$HOME/Library/LaunchAgents
domain=gui/$(id -u)

job_pid() {
    launchctl print "$domain/$1" 2>/dev/null | awk '$1 == "pid" { print $3; exit }'
}

for stale in "${stale_labels[@]}"; do
    if launchctl print "$domain/$stale" &>/dev/null; then
        echo "Unloading stale agent: $stale"
        launchctl bootout "$domain/$stale" || true
    fi
    if [[ -f $agents_dir/$stale.plist ]]; then
        echo "Removing $agents_dir/$stale.plist"
        rm "$agents_dir/$stale.plist"
    fi
done

if [[ -z $(job_pid "$label") ]]; then
    echo "Starting $label"
    yabai --start-service
    sleep 2
fi

pid=$(job_pid "$label")
if [[ -z $pid ]]; then
    echo "error: $label failed to start; see /tmp/yabai_$USER.err.log" >&2
    exit 1
fi

for stray in $(pgrep -x yabai); do
    if [[ $stray != "$pid" ]]; then
        echo "Killing stray yabai process: $stray"
        kill "$stray"
    fi
done

echo "yabai running (pid $pid) via $label"
