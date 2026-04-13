# tmux-config

My personal tmux configuration — Catppuccin Mocha theme, vim-style navigation, mouse support, and sane defaults.

![demo](demo.gif)

## Install

```sh
git clone --recursive https://github.com/IdoSagiv/tmux-config.git ~/tmux-config
cd ~/tmux-config
./install.sh
```

The installer symlinks config files into place and installs plugins via TPM.
Any existing `~/.tmux.conf` is backed up to `~/.tmux.conf.bak.<timestamp>`.

To remove:

```sh
./install.sh --uninstall
```

### Dependencies

- tmux 3.2+
- git
- xclip (for clipboard integration on X11)

## The 30-second tour

**Prefix:** `Ctrl+b` (default).

| What | Keys |
|---|---|
| Move between panes | `Alt+h/j/k/l` (no prefix) |
| Jump to window | `Alt+1..9` (no prefix) |
| Split vertical | `prefix \|` |
| Split horizontal | `prefix -` |
| Resize panes | `prefix H/J/K/L` (repeatable) |
| Swap windows | `prefix <` / `prefix >` |
| Swap panes | `prefix Shift+Arrow` |
| New window (cwd) | `prefix c` |
| Kill pane | `prefix x` |
| Sync panes (broadcast) | `prefix e` |
| Reload config | `prefix r` |

**Copy/paste — vim-style:**

- Enter copy mode: `prefix [`
- `v` to begin selection, `y` to yank to system clipboard
- `Ctrl+v` to toggle rectangle select, `Escape` to cancel
- `prefix P` to paste from tmux buffer
- Mouse drag auto-copies to clipboard
- Double-click copies word, triple-click copies line
- Middle-click pastes from X primary selection

**Smart scrolling:** scroll wheel works in regular panes; inside vim it sends `Ctrl+y`/`Ctrl+e` instead.

## Features

- **Catppuccin Mocha** color scheme — status bar, pane borders, window tabs
- **Status bar** shows user@host (or remote SSH host), session name, git branch, time, and date
- **Vim-style** keybindings throughout (hjkl navigation, vi copy mode)
- **Mouse support** with intelligent vim detection
- **256-color / true color** terminal support
- **Automatic window rename** based on current directory
- **Pane dimming** — inactive panes are visually dimmed
- **TPM plugins** — tmux-yank for clipboard integration

## Files

| File | Purpose |
|---|---|
| `tmux.conf` | Main config → symlinked to `~/.tmux.conf` |
| `scripts/user_host.sh` | Status bar script → symlinked to `~/.tmux/scripts/` |
| `plugins/tpm/` | Tmux Plugin Manager (git submodule) |
| `install.sh` | Installer / uninstaller |
| `demo.tape` | VHS script — run `vhs demo.tape` to regenerate `demo.gif` |

## Customizing

Edit `tmux.conf` in the repo and press `prefix r` inside tmux. The installer
symlinks the file, so repo edits take effect immediately.
