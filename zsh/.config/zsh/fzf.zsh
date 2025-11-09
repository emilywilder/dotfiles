#!/usr/bin/env zsh

if which fzf >/dev/null; then
    eval "$(fzf --zsh)"
fi
