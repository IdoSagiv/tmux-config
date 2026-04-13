#!/bin/bash
# Show remote user@host if pane is running ssh, otherwise local
pane_pid="$1"
ssh_pid=$(pgrep -P "$pane_pid" -x ssh 2>/dev/null | head -1)
if [ -n "$ssh_pid" ]; then
    ssh_args=$(ps -o args= -p "$ssh_pid" 2>/dev/null)
    # Get the destination (last argument)
    host=$(echo "$ssh_args" | awk '{print $NF}')
    if [ -n "$host" ]; then
        # If destination already has user@ use it as-is
        if [[ "$host" == *@* ]]; then
            echo "$host"
            exit 0
        fi
        # Resolve effective user from ssh config (-G does a dry run)
        user=$(ssh -G "$host" 2>/dev/null | awk '/^user /{print $2; exit}')
        [ -z "$user" ] && user=$(whoami)
        echo "${user}@${host}"
        exit 0
    fi
fi
echo "$(whoami)@$(hostname -s)"
