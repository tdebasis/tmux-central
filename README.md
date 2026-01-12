# tmux-central

A collection of bash scripts for managing tmux sessions, with a pre-configured setup featuring vim-style navigation and a clean status bar.

![Personal config](https://img.shields.io/badge/Personal%20config-red) *to sync my tmux setup across machines and accounts.*

## Features

- Quick session creation and management
- Interactive session picker
- Vim-style pane navigation (hjkl)
- Tokyo Night-inspired status bar
- Session persistence with tmux-resurrect/continuum
- macOS clipboard integration
- Mouse support

## Installation

```bash
./install.sh
```

This installs:
- tmux (via Homebrew)
- tmux plugin manager (tpm)
- Links `tmux.conf` to `~/.tmux.conf`

After installation, press `Ctrl-b I` inside tmux to install plugins.

## Usage

### Create a new session
```bash
./new-session.sh <name> [path]

# Examples
./new-session.sh frontend ~/projects/my-app
./new-session.sh api
```

### Manage sessions
```bash
./sessions.sh              # List all sessions
./sessions.sh attach       # Interactive picker
./sessions.sh attach api   # Attach to specific session
./sessions.sh kill api     # Kill specific session
./sessions.sh kill-all     # Kill all sessions
```

## Key Bindings

All bindings use `Ctrl-b` as prefix (press `Ctrl-b`, release, then press the key).

### Sessions & Windows
| Binding | Action |
|---------|--------|
| `d` | Detach from session |
| `c` | New window |
| `n` / `p` | Next / previous window |
| `M-1` to `M-5` | Quick switch to window 1-5 |

### Panes
| Binding | Action |
|---------|--------|
| `\|` | Split vertical |
| `-` | Split horizontal |
| `h` `j` `k` `l` | Navigate panes (vim-style) |
| `H` `J` `K` `L` | Resize panes |
| `z` | Toggle pane zoom |

### Copy Mode
| Binding | Action |
|---------|--------|
| `[` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy to clipboard |
| `/` | Search forward |

### Misc
| Binding | Action |
|---------|--------|
| `r` | Reload config |
| `?` | List all bindings |

## Session Persistence

Sessions are automatically saved every 15 minutes and restored on tmux start.

- `Ctrl-b Ctrl-s` - Manual save
- `Ctrl-b Ctrl-r` - Manual restore

## License

MIT
