#!/bin/bash
# tmux-central: Kill a tmux session
# Usage: ./kill-session.sh <session-name>

SESSION_NAME="$1"

if [ -z "$SESSION_NAME" ]; then
    echo "Usage: ./kill-session.sh <session-name>"
    echo ""
    echo "Active sessions:"
    tmux list-sessions -F "  #S" 2>/dev/null || echo "  (none)"
    exit 1
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux kill-session -t "$SESSION_NAME"
    echo "Session '$SESSION_NAME' killed."
else
    echo "Session '$SESSION_NAME' not found."
    exit 1
fi
