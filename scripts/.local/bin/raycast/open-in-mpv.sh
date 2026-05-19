#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in mpv
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎬
# @raycast.argument1 { "type": "text", "placeholder": "URL (Leave blank for clipboard)", "optional": true }
# @raycast.packageName Media

# Documentation:
# @raycast.description Opens a specific URL or your current clipboard in mpv.
# @raycast.author YourName

# 1. Ensure Homebrew paths are active (Raycast doesn't load your shell profile by default)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# 2. Grab the argument
URL="$1"

# 3. Quality of Life: If no URL is provided, fallback to the current clipboard contents
if [ -z "$URL" ]; then
  URL=$(pbpaste)
fi

# 4. Check if we actually have a URL to open
if [[ -z "$URL" || ! "$URL" =~ ^https?:// ]]; then
  echo "No valid URL found"
  exit 1
fi

# 5. Run mpv detached in the background so Raycast can close instantly
nohup mpv "$URL" > /dev/null 2>&1 &

echo "Opening video..."
