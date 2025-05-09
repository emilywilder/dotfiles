# emacs editing mode
bindkey -e

# potentially useful keybinds
#bindkey "$(echotc kl)" backward-char
#bindkey "$(echotc kr)" forward-char
#bindkey "$(echotc ku)" up-line-or-history
#bindkey "$(echotc kd)" down-line-or-history

#bindkey '^[[1~' beginning-of-line
#bindkey '\eOH' beginning-of-line
#bindkey '^[[4~' end-of-line
#bindkey '\eOF' end-of-line

# CTRL-left and CTRL-right moving by word
# may be macOS specific
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word