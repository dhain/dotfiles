#!/bin/sh

if [ -e /usr/bin/tmux ]; then
    TMUX=/usr/bin/tmux
elif [ -e /usr/local/bin/tmux ]; then
    TMUX=/usr/local/bin/tmux
    export PATH="/usr/local/bin:$PATH"
elif [ -e /opt/homebrew/bin/tmux ]; then
    TMUX=/opt/homebrew/bin/tmux
    export PATH="/opt/homebrew/bin:$PATH"
fi

if "$TMUX" list-sessions >/dev/null 2>&1; then
    exec "$TMUX" attach "$@"
else
    exec "$TMUX" "$@"
fi
