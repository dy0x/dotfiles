#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in IINA
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎬
# @raycast.argument1 { "type": "text", "placeholder": "URL (Leave blank for clipboard)", "optional": true }
# @raycast.packageName Media

# Grab the argument
URL="$1"

# Fallback to clipboard if argument is empty
if [ -z "$URL" ]; then
  URL=$(pbpaste)
fi

# Validate URL
if [[ -z "$URL" || ! "$URL" =~ ^https?:// ]]; then
  echo "No valid URL found"
  exit 1
fi

# Open the stream in IINA
open -a "IINA" "$URL"

echo "Opening in IINA..."
