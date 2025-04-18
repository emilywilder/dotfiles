autoload -U compinit
compinit
autoload -U colors
colors
autoload -U vcs_info

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# don't cycle through options
setopt NO_AUTO_MENU
# allow parameter expansion, command substitution and arithmetic expansion
# before the prompt is evaluated
setopt PROMPT_SUBST
# commands to be appended to the history file, and new shells read history
setopt SHARE_HISTORY

bindkey -e

bindkey "$(echotc kl)" backward-char
bindkey "$(echotc kr)" forward-char
bindkey "$(echotc ku)" up-line-or-history
bindkey "$(echotc kd)" down-line-or-history

bindkey '^[[1~' beginning-of-line
bindkey '\eOH' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '\eOF' end-of-line

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '⎇  %b'
zstyle ':vcs_info:*' get-revision true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

RPROMPT='[%?]'
PROMPT='%B%F{green}%~%f %B%F{cyan}${vcs_info_msg_0_}%f
%F{white}%n@%m %# %f%b'

alias ll='ls -al'
alias lsd='ls -al | grep ^d'
alias paths='echo $PATH | tr ":" "\n"'
alias vi='vim'
alias diff='diff -u --color'
alias gittree='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
