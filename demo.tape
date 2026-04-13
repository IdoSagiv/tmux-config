# Generates demo.gif. Install vhs (https://github.com/charmbracelet/vhs)
# then run:   vhs demo.tape
# (vhs bundles ttyd + ffmpeg, so no other deps needed.)

Output demo.gif

Set Shell        "bash"
Set FontSize     16
Set Width        1100
Set Height       680
Set Theme        "Catppuccin Mocha"
Set Padding      20
Set TypingSpeed  50ms
Set PlaybackSpeed 1.0

# === Setup (hidden) ==========================================================
# Create a clean prompt and an isolated tmux session so the GIF
# doesn't leak machine-specific info. Uses a separate socket (-L vhsdemo).
Hide
Type "cat > /tmp/vhsdemo-rc <<'EOF'" Enter
Type "PS1='\[\033[1;36m\]❯\[\033[0m\] '" Enter
Type "unset PROMPT_COMMAND" Enter
Type "EOF" Enter
Type "cat > /tmp/vhsdemo-tmux.conf <<'EOF'" Enter
Type "source-file ./tmux.conf" Enter
Type "set -g default-command 'bash --rcfile /tmp/vhsdemo-rc -i'" Enter
Type "set -g status-right '#[fg=#89b4fa]main #[fg=#585b70]| #[fg=#f9e2af]14:30 #[fg=#585b70]| #[fg=#cdd6f4]13-Apr-26'" Enter
Type "EOF" Enter
Type "tmux -L vhsdemo kill-server 2>/dev/null; clear" Enter
Sleep 300ms
Type "tmux -L vhsdemo -f /tmp/vhsdemo-tmux.conf new-session -s demo" Enter
Sleep 1500ms
Show

# === Show theme & basic commands =============================================
Sleep 700ms
Type "echo 'Welcome to my tmux config!'" Enter
Sleep 800ms
Type "ls" Enter
Sleep 700ms

# === Split panes (prefix | and prefix -) ====================================
# Vertical split
Ctrl+b
Type "|"
Sleep 500ms
Type "echo 'vertical split: prefix |'" Enter
Sleep 600ms

# Horizontal split in right pane
Ctrl+b
Type "-"
Sleep 500ms
Type "echo 'horizontal split: prefix -'" Enter
Sleep 600ms

# === Navigate panes (Alt+hjkl, no prefix) ===================================
Alt+h
Sleep 400ms
Alt+l
Sleep 400ms
Alt+j
Sleep 400ms
Alt+k
Sleep 500ms

# === Resize panes (prefix H/J/K/L, repeatable) ==============================
Alt+h
Sleep 300ms
Ctrl+b
Type "LLLL"
Sleep 500ms
Ctrl+b
Type "JJJ"
Sleep 500ms

# === Swap panes (prefix Shift+Arrow) ========================================
# Focus left pane, then swap it right
Alt+h
Sleep 400ms
Type "echo 'I will swap right →'" Enter
Sleep 500ms
Ctrl+b
Shift+Right
Sleep 600ms

# === Sync panes (prefix e — type in all panes at once) ======================
Ctrl+b
Type "e"
Sleep 400ms
Type "echo 'synced!'" Enter
Sleep 800ms
# Turn sync off
Ctrl+b
Type "e"
Sleep 400ms

# === Kill extra panes (prefix x) ============================================
Alt+l
Sleep 300ms
Alt+j
Sleep 300ms
Ctrl+b
Type "x"
Sleep 400ms
Ctrl+b
Type "x"
Sleep 500ms

# === Copy mode (vim keys) ====================================================
Type "echo 'copy with vim keys: v to select, y to yank'" Enter
Sleep 700ms
# Enter copy mode
Ctrl+b
Type "["
Sleep 400ms
Type "k"
Sleep 200ms
Type "0"
Sleep 200ms
Type "v"
Sleep 300ms
Type "$"
Sleep 400ms
Type "y"
Sleep 500ms
# Paste
Type "echo 'pasted: "
Ctrl+b
Type "P"
Type "'"
Enter
Sleep 800ms

# === New window + switch (prefix c, Alt+1/2) ================================
Ctrl+b
Type "c"
Sleep 500ms
Type "echo 'window 2 — switch with Alt+1/2'" Enter
Sleep 700ms
# Alt+1 = Escape then 1 (how terminals send Alt+digit)
Escape
Type "1"
Sleep 500ms
Escape
Type "2"
Sleep 500ms

# === Swap windows (prefix < / >) ============================================
# Window 2 is active — move it left to become window 1
Ctrl+b
Type "<"
Sleep 800ms

# === Create a second session and switch ======================================
Hide
Type "tmux -L vhsdemo new-session -d -s work" Enter
Sleep 500ms
Show

# Session tree (prefix s)
Ctrl+b
Type "s"
Sleep 1200ms
# Select the other session
Down
Sleep 400ms
Enter
Sleep 600ms

# Toggle back to last session (prefix S)
Ctrl+b
Type "S"
Sleep 800ms

# === Reload config (prefix r) ===============================================
Ctrl+b
Type "r"
Sleep 1500ms

# === Detach ==================================================================
Ctrl+b
Type "d"
Sleep 600ms

# === Cleanup (hidden) ========================================================
Hide
Type "tmux -L vhsdemo kill-server 2>/dev/null; rm -f /tmp/vhsdemo-rc /tmp/vhsdemo-tmux.conf; clear" Enter
