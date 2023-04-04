#!/bin/bash
tmuxsessions=$(tmux list-sessions -F "#{session_name}")

FZF_TMUX=fzf-tmux -p 50,50

tmux_switch_to_session() {
    session="$1"
    if [[ $tmuxsessions = *"$session"* ]]; then
        tmux switch-client -t "$session"
    fi
}

choice=$(sort -rfu <<< "$tmuxsessions" | fzf-tmux -p 30,20 | tr -d '\n')

tmux_switch_to_session "$choice"
