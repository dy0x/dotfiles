#!/bin/bash

set -euo pipefail
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

repair=0
anywhere=0

if [[ "${1:-}" == "--anywhere" ]]; then
    anywhere=1
    shift
fi

if [[ "${1:-}" == "--repair" ]]; then
    repair=1
    shift
fi

if [[ $# -lt 2 ]]; then
    echo "usage: aerospace-home.sh [--anywhere|--repair] <workspace> <bundle-id-or-> [open-spec]" >&2
    exit 1
fi

workspace="$1"
bundle_id="$2"
open_spec="${3:-}"

open_app() {
    if [[ -n "$open_spec" ]]; then
        case "$open_spec" in
            app:*)
                open -a "${open_spec#app:}"
                ;;
            bundle:*)
                open -b "${open_spec#bundle:}"
                ;;
            profile:*)
                open -na "Brave Browser.app" --args --profile-directory="${open_spec#profile:}"
                ;;
            *)
                open -a "$open_spec"
                ;;
        esac
        return
    fi

    if [[ "$bundle_id" != "-" ]]; then
        open -b "$bundle_id"
    fi
}

first_window=""
window_count=0

if (( ! anywhere )); then
    aerospace workspace "$workspace"
fi

if [[ "$bundle_id" != "-" ]]; then
    if (( repair || anywhere )); then
        scope=(--monitor all)
    else
        scope=(--workspace "$workspace")
    fi

    while IFS=$'\t' read -r window_id current_workspace; do
        [[ -z "$window_id" ]] && continue
        window_count=$((window_count + 1))

        if (( repair )) && [[ "$current_workspace" != "$workspace" ]]; then
            aerospace move-node-to-workspace --window-id "$window_id" "$workspace" >/dev/null 2>&1 || true
        fi

        if [[ -z "$first_window" ]]; then
            first_window="$window_id"
        fi
    done < <(
        aerospace list-windows "${scope[@]}" \
            --app-bundle-id "$bundle_id" \
            --format '%{window-id}%{tab}%{workspace}' 2>/dev/null || true
    )
fi

if (( window_count == 0 )); then
    aerospace workspace "$workspace"
    open_app
else
    if (( ! anywhere )); then
        aerospace workspace "$workspace"
    fi

    if [[ -n "$first_window" ]]; then
        aerospace focus --window-id "$first_window" >/dev/null 2>&1 || true
    fi

fi
