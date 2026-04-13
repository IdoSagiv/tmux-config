#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

# ── Uninstall ────────────────────────────────────────────────────────────────
if [[ "${1:-}" == "--uninstall" ]]; then
    echo "Uninstalling tmux-config..."

    for target in ~/.tmux.conf ~/.tmux/scripts/user_host.sh ~/.tmux/plugins/tpm; do
        if [[ -L "$target" ]]; then
            rm -v "$target"
            # Restore most recent backup if one exists
            backup="$(ls -1t "${target}.bak."* 2>/dev/null | head -1 || true)"
            if [[ -n "$backup" ]]; then
                mv -v "$backup" "$target"
            fi
        fi
    done

    echo "Done. Restart tmux or run: tmux source-file ~/.tmux.conf"
    exit 0
fi

# ── Install ──────────────────────────────────────────────────────────────────
echo "Installing tmux-config from $REPO_DIR ..."

# Back up and symlink ~/.tmux.conf
if [[ -e ~/.tmux.conf && ! -L ~/.tmux.conf ]]; then
    mv -v ~/.tmux.conf ~/.tmux.conf.bak."$TIMESTAMP"
fi
ln -sfv "$REPO_DIR/tmux.conf" ~/.tmux.conf

# Back up and symlink user_host.sh
mkdir -p ~/.tmux/scripts
if [[ -e ~/.tmux/scripts/user_host.sh && ! -L ~/.tmux/scripts/user_host.sh ]]; then
    mv -v ~/.tmux/scripts/user_host.sh ~/.tmux/scripts/user_host.sh.bak."$TIMESTAMP"
fi
ln -sfv "$REPO_DIR/scripts/user_host.sh" ~/.tmux/scripts/user_host.sh

# Ensure TPM submodule is present
(cd "$REPO_DIR" && git submodule update --init --recursive)

# Symlink TPM into the standard location
mkdir -p ~/.tmux/plugins
if [[ -e ~/.tmux/plugins/tpm && ! -L ~/.tmux/plugins/tpm ]]; then
    mv -v ~/.tmux/plugins/tpm ~/.tmux/plugins/tpm.bak."$TIMESTAMP"
fi
ln -sfv "$REPO_DIR/plugins/tpm" ~/.tmux/plugins/tpm

# Install TPM plugins
if [[ -x ~/.tmux/plugins/tpm/bin/install_plugins ]]; then
    echo "Installing tmux plugins via TPM..."
    ~/.tmux/plugins/tpm/bin/install_plugins
fi

# Reload tmux if running
if tmux info &>/dev/null; then
    tmux source-file ~/.tmux.conf
    echo "Tmux config reloaded."
fi

echo ""
echo "Done! If tmux is not running, start it and plugins will load automatically."
echo "Or press prefix + I inside tmux to install plugins."
