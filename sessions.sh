#!/bin/bash
# tmux-central: List and manage tmux sessions
# Usage: ./sessions.sh [command] [session-name]

set -e

COMMAND="$1"
SESSION_NAME="$2"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo -e "${YELLOW}tmux is not installed. Run ./install.sh first.${NC}"
    exit 1
fi

# Check if tmux server is running
tmux_running() {
    tmux list-sessions &>/dev/null
}

list_sessions() {
    echo -e "${BOLD}=== tmux Sessions ===${NC}"
    echo ""

    if ! tmux_running; then
        echo -e "${YELLOW}No active sessions.${NC}"
        echo ""
        echo "Create one with: ./new-session.sh <name>"
        return
    fi

    echo -e "${CYAN}Active sessions:${NC}"
    echo ""
    tmux list-sessions -F "  #S (#{session_windows} windows) - created #{session_created_string}" 2>/dev/null || echo "  None"
    echo ""
}

attach_session() {
    if ! tmux_running; then
        echo -e "${YELLOW}No active sessions to attach to.${NC}"
        exit 1
    fi

    if [ -n "$SESSION_NAME" ]; then
        # Attach to specific session
        if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
            tmux attach -t "$SESSION_NAME"
        else
            echo -e "${RED}Session '$SESSION_NAME' not found.${NC}"
            echo ""
            list_sessions
            exit 1
        fi
    else
        # Show list and let user choose
        sessions=$(tmux list-sessions -F "#S" 2>/dev/null)
        session_count=$(echo "$sessions" | wc -l | tr -d ' ')

        if [ "$session_count" -eq 1 ]; then
            # Only one session, attach directly
            tmux attach -t "$(echo "$sessions" | head -1)"
        else
            # Multiple sessions, show picker
            echo -e "${BOLD}Select a session to attach:${NC}"
            echo ""

            i=1
            while IFS= read -r session; do
                echo "  $i) $session"
                i=$((i + 1))
            done <<< "$sessions"

            echo ""
            read -p "Enter number (or session name): " choice

            if [[ "$choice" =~ ^[0-9]+$ ]]; then
                selected=$(echo "$sessions" | sed -n "${choice}p")
                if [ -n "$selected" ]; then
                    tmux attach -t "$selected"
                else
                    echo -e "${RED}Invalid selection.${NC}"
                    exit 1
                fi
            else
                tmux attach -t "$choice"
            fi
        fi
    fi
}

kill_session() {
    if [ -z "$SESSION_NAME" ]; then
        echo "Usage: ./sessions.sh kill <session-name>"
        echo ""
        list_sessions
        exit 1
    fi

    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        read -p "Kill session '$SESSION_NAME'? (y/n) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            tmux kill-session -t "$SESSION_NAME"
            echo -e "${GREEN}Session '$SESSION_NAME' killed.${NC}"
        fi
    else
        echo -e "${RED}Session '$SESSION_NAME' not found.${NC}"
        exit 1
    fi
}

kill_all() {
    if ! tmux_running; then
        echo -e "${YELLOW}No active sessions.${NC}"
        exit 0
    fi

    read -p "Kill ALL tmux sessions? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        tmux kill-server
        echo -e "${GREEN}All sessions killed.${NC}"
    fi
}

show_help() {
    echo -e "${BOLD}tmux-central: Session Manager${NC}"
    echo ""
    echo "Usage: ./sessions.sh [command] [session-name]"
    echo ""
    echo "Commands:"
    echo "  (none)              List all sessions"
    echo "  list                List all sessions"
    echo "  attach [name]       Attach to a session (interactive picker if no name)"
    echo "  kill <name>         Kill a specific session"
    echo "  kill-all            Kill all sessions"
    echo "  help                Show this help"
    echo ""
    echo "Examples:"
    echo "  ./sessions.sh                  # List sessions"
    echo "  ./sessions.sh attach           # Pick a session to attach"
    echo "  ./sessions.sh attach frontend  # Attach to 'frontend'"
    echo "  ./sessions.sh kill api         # Kill 'api' session"
    echo ""
    echo "Quick tmux commands:"
    echo "  Ctrl-b d     Detach from session"
    echo "  Ctrl-b c     New window"
    echo "  Ctrl-b n/p   Next/previous window"
    echo "  Ctrl-b %     Split vertical"
    echo "  Ctrl-b \"     Split horizontal"
}

# Main
case "$COMMAND" in
    ""|"list")
        list_sessions
        ;;
    "attach"|"a")
        attach_session
        ;;
    "kill"|"k")
        kill_session
        ;;
    "kill-all"|"ka")
        kill_all
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        # Assume it's a session name to attach to
        SESSION_NAME="$COMMAND"
        attach_session
        ;;
esac
