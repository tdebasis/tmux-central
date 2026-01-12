#!/bin/bash
# tmux-central: Install tmux and set up configuration
# Usage: ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== tmux-central installer ==="
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo ""
fi

# Install tmux
if command -v tmux &> /dev/null; then
    echo "tmux is already installed: $(tmux -V)"
else
    echo "Installing tmux..."
    brew install tmux
    echo "tmux installed: $(tmux -V)"
fi

# Install iTerm2
if [ -d "/Applications/iTerm.app" ]; then
    echo "iTerm2 is already installed."
else
    echo "Installing iTerm2..."
    brew install --cask iterm2
    echo "iTerm2 installed."
fi

echo ""

# Link tmux config if it exists
if [ -f "$SCRIPT_DIR/tmux.conf" ]; then
    echo "Linking tmux.conf to ~/.tmux.conf..."

    # Backup existing config if present
    if [ -f ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ]; then
        echo "  Backing up existing ~/.tmux.conf to ~/.tmux.conf.backup"
        mv ~/.tmux.conf ~/.tmux.conf.backup
    fi

    ln -sf "$SCRIPT_DIR/tmux.conf" ~/.tmux.conf
    echo "  Config linked!"
fi

# Make scripts executable
chmod +x "$SCRIPT_DIR"/*.sh 2>/dev/null || true

echo ""
echo "=== Installation complete ==="
echo ""
echo "Quick start:"
echo "  ./new-session.sh <name>   - Start a new Claude session"
echo "  ./sessions.sh             - List/manage sessions"
echo "  ./sessions.sh attach      - Attach to a session"
echo ""
echo "tmux basics:"
echo "  Ctrl-b d     - Detach from session"
echo "  Ctrl-b c     - New window"
echo "  Ctrl-b %     - Split vertical"
echo "  Ctrl-b \"     - Split horizontal"
