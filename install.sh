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

# Install TextMate
if [ -d "/Applications/TextMate.app" ]; then
    echo "TextMate is already installed."
else
    echo "Installing TextMate..."
    brew install --cask textmate
    echo "TextMate installed."
fi

# Install micro (terminal editor - familiar shortcuts)
if command -v micro &> /dev/null; then
    echo "micro is already installed."
else
    echo "Installing micro..."
    brew install micro
    echo "micro installed."
fi

# Install neovim (terminal editor - powerful)
if command -v nvim &> /dev/null; then
    echo "neovim is already installed."
else
    echo "Installing neovim..."
    brew install neovim
    echo "neovim installed."
fi

# Install glow (terminal markdown renderer)
if command -v glow &> /dev/null; then
    echo "glow is already installed."
else
    echo "Installing glow..."
    brew install glow
    echo "glow installed."
fi

# Install tpm (tmux plugin manager)
if [ -d ~/.tmux/plugins/tpm ]; then
    echo "tpm (tmux plugin manager) is already installed."
else
    echo "Installing tpm (tmux plugin manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "tpm installed."
fi

# Install tmux plugins via tpm (after config is linked)
install_tmux_plugins() {
    if [ -f ~/.tmux/plugins/tpm/bin/install_plugins ]; then
        echo "Installing tmux plugins..."
        bash ~/.tmux/plugins/tpm/bin/install_plugins
        echo "tmux plugins installed."
    fi
}

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

# Install tmux plugins (now that config is linked)
install_tmux_plugins

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
echo ""
echo "Session save/restore:"
echo "  Ctrl-b I       - Install plugins (run once after first install)"
echo "  Ctrl-b Ctrl-s  - Save session"
echo "  Ctrl-b Ctrl-r  - Restore session"
