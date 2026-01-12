#!/bin/bash
# tmux-central: Create a new tmux session for Claude CLI
# Usage: ./new-session.sh <session-name> [project-path]

set -e

SESSION_NAME="$1"
PROJECT_PATH="$2"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: ./new-session.sh <session-name> [project-path]"
    echo ""
    echo "Arguments:"
    echo "  session-name   Name for the tmux session (e.g., 'frontend', 'api')"
    echo "  project-path   Optional: Directory to start in (defaults to current dir)"
    echo ""
    echo "Examples:"
    echo "  ./new-session.sh frontend ~/projects/my-app"
    echo "  ./new-session.sh api"
    echo "  ./new-session.sh debug /tmp"
    echo ""
    echo "Tip: Use descriptive names like project-feature (e.g., 'app-auth', 'api-refactor')"
    exit 1
}

# Require session name
if [ -z "$SESSION_NAME" ]; then
    usage
fi

# Default to current directory if no path provided
if [ -z "$PROJECT_PATH" ]; then
    PROJECT_PATH="$(pwd)"
fi

# Expand path
PROJECT_PATH=$(cd "$PROJECT_PATH" 2>/dev/null && pwd || echo "$PROJECT_PATH")

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo -e "${YELLOW}tmux is not installed. Run ./install.sh first.${NC}"
    exit 1
fi

# Check if session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo -e "${YELLOW}Session '$SESSION_NAME' already exists.${NC}"
    echo ""
    echo "Options:"
    echo "  1. Attach to it:  tmux attach -t $SESSION_NAME"
    echo "  2. Kill it first: tmux kill-session -t $SESSION_NAME"
    echo ""
    read -p "Attach to existing session? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        tmux attach -t "$SESSION_NAME"
    fi
    exit 0
fi

# Create new session
echo -e "${GREEN}Creating session: ${CYAN}$SESSION_NAME${NC}"
echo -e "Directory: $PROJECT_PATH"
echo ""

tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_PATH"

# Rename first window (use :0 since base-index isn't applied until config loads)
tmux rename-window -t "$SESSION_NAME:0" "main"

# Attach to the session
echo -e "${GREEN}Session created! Attaching...${NC}"
echo ""
echo -e "Tip: Start Claude CLI with: ${CYAN}claude${NC}"
echo ""

tmux attach -t "$SESSION_NAME"
