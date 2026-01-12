# tmux Command Reference

All commands use `Ctrl-b` as the prefix (press `Ctrl-b`, release, then press the key).

## Session Management

| Command | Description |
|---------|-------------|
| `tmux new -s name` | Create new session with name |
| `tmux ls` | List all sessions |
| `tmux attach -t name` | Attach to a session |
| `tmux kill-session -t name` | Kill a session |
| `Ctrl-b d` | Detach from current session |
| `Ctrl-b $` | Rename current session |
| `Ctrl-b s` | List and switch sessions |

## Windows (Tabs)

| Command | Description |
|---------|-------------|
| `Ctrl-b c` | Create new window |
| `Ctrl-b ,` | Rename current window |
| `Ctrl-b n` | Next window |
| `Ctrl-b p` | Previous window |
| `Ctrl-b 0-9` | Switch to window by number |
| `M-1` to `M-5` | Quick switch to window 1-5 (Alt/Option + number) |
| `Ctrl-b w` | List and select windows |
| `Ctrl-b &` | Kill current window (with confirmation) |

## Panes (Splits)

### Creating Panes

| Command | Description |
|---------|-------------|
| `Ctrl-b \|` | Split vertically (side by side) |
| `Ctrl-b -` | Split horizontally (top/bottom) |
| `Ctrl-b %` | Split vertically (default binding) |
| `Ctrl-b "` | Split horizontally (default binding) |

### Navigating Panes

| Command | Description |
|---------|-------------|
| `Ctrl-b h` | Move to left pane |
| `Ctrl-b j` | Move to pane below |
| `Ctrl-b k` | Move to pane above |
| `Ctrl-b l` | Move to right pane |
| `Ctrl-b o` | Cycle through panes |
| `Ctrl-b q` | Show pane numbers (press number to jump) |

### Resizing Panes

| Command | Description |
|---------|-------------|
| `Ctrl-b H` | Resize pane left |
| `Ctrl-b J` | Resize pane down |
| `Ctrl-b K` | Resize pane up |
| `Ctrl-b L` | Resize pane right |
| `Ctrl-b z` | Toggle pane zoom (fullscreen) |

### Managing Panes

| Command | Description |
|---------|-------------|
| `Ctrl-b x` | Kill current pane (with confirmation) |
| `Ctrl-b !` | Convert pane to new window |
| `Ctrl-b {` | Move pane left |
| `Ctrl-b }` | Move pane right |
| `Ctrl-b Space` | Cycle through pane layouts |

## Copy Mode (Scrolling & Selection)

| Command | Description |
|---------|-------------|
| `Ctrl-b [` | Enter copy mode |
| `q` | Exit copy mode |
| `↑/↓` or `k/j` | Scroll up/down |
| `Ctrl-u` | Page up |
| `Ctrl-d` | Page down |
| `g` | Go to top |
| `G` | Go to bottom |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search match |
| `N` | Previous search match |
| `v` | Begin selection |
| `y` | Copy selection (to clipboard on macOS) |

## Misc

| Command | Description |
|---------|-------------|
| `Ctrl-b r` | Reload tmux config |
| `Ctrl-b t` | Show clock |
| `Ctrl-b ?` | List all key bindings |
| `Ctrl-b :` | Enter command mode |

## Command Line

```bash
# Sessions
tmux new -s name              # New session
tmux new -s name -c ~/path    # New session in directory
tmux ls                       # List sessions
tmux attach -t name           # Attach to session
tmux kill-session -t name     # Kill session
tmux kill-server              # Kill all sessions

# Info
tmux info                     # Show tmux info
tmux list-keys                # List all bindings
```

## Tips

- **Mouse works**: Click to select panes, scroll to browse history
- **Zoom**: `Ctrl-b z` makes current pane fullscreen (press again to restore)
- **Quick switch**: Use `Ctrl-b s` to see all sessions and windows in a tree view
- **Copy on macOS**: Select text with mouse, it auto-copies to clipboard

## Resources

- [tmux Tutorial Video](https://www.youtube.com/watch?v=nTqu6w2wc68)
