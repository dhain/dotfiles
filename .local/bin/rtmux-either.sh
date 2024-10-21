#!/bin/sh

TE=$(cat `dirname $0`/tmux-either.sh)
exec ssh "$1" -t /bin/sh -c "$TE"
