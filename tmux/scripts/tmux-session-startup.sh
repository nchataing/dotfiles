#!/bin/bash
SESSIONS_FILE='/home/nchataing/.tmux.sessions'

tmux new-session -d -s main

# Get current sessions
current_sessions=$(tmux list-sessions -F "#{session_name}")

while read line; do
    IFS=, read -r session path <<< $line
    if ! [[ $current_sessions = *"$session"* ]]; then
        tmux new-session -d -s "$session"
        tmux send-keys -t "$session" "cd $path" Enter
        tmux send-keys -t "$session" "C-l"
    fi

done < $SESSIONS_FILE

tmux attach -t main
