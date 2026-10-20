#!/usr/bin/env bash

# Ensure exactly one skhd daemon runs, via skhd-zig's app-bundled
# com.jackielii.skhd agent (registered with SMAppService). Removes stale agents
# left by older installs (koekeishiya skhd, brew services, pre-0.1 skhd-zig
# plists) and kills stray processes. Safe to re-run.

set -euo pipefail

label=com.jackielii.skhd
stale_labels=(
    com.koekeishiya.skhd
    homebrew.mxcl.skhd
    homebrew.mxcl.skhd-zig
)
agents_dir=$HOME/Library/LaunchAgents
domain=gui/$(id -u)

# skhd-zig must register its service from inside the .app bundle
skhd_app=$(brew --prefix skhd-zig)/skhd.app
skhd_bin=$skhd_app/Contents/MacOS/skhd

job_pid() {
    launchctl print "$domain/$1" 2>/dev/null | awk '$1 == "pid" { print $3; exit }'
}

# skhd-zig < 0.1 installed a plain plist under the same label as the current
# app-bundled agent, so only unload it when that legacy plist file exists
if [[ -f $agents_dir/$label.plist ]]; then
    stale_labels+=("$label")
fi

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
    echo "Registering $label from $skhd_app"
    "$skhd_bin" --install-service </dev/null
    sleep 2
fi

pid=$(job_pid "$label")
if [[ -z $pid ]]; then
    echo "error: $label failed to start; see ~/Library/Logs/skhd.log" >&2
    echo "Grant Accessibility to $skhd_app, then re-run this script" >&2
    exit 1
fi

for stray in $(pgrep -x skhd); do
    if [[ $stray != "$pid" ]]; then
        echo "Killing stray skhd process: $stray"
        kill "$stray"
    fi
done

echo "skhd running (pid $pid) via $label"
