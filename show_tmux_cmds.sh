#!/bin/bash
# Open tmux command reference in Typora
# Usage: ./show_tmux_cmds.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MD_FILE="$SCRIPT_DIR/TMUX_COMMANDS.md"

if [ ! -f "$MD_FILE" ]; then
    echo "Error: TMUX_COMMANDS.md not found"
    exit 1
fi

open -a "Typora" "$MD_FILE"
