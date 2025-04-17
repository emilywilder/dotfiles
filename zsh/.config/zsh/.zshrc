autoload -U compinit
compinit
autoload -U colors
colors
autoload -U vcs_info

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt shwordsplit
setopt appendhistory
setopt incappendhistory
setopt noautomenu
setopt prompt_subst

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
alias paths='echo $PATH | tr ":" "\n" | sort'
alias vi='vim'
alias diff='diff -u --color'
alias gittree='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
export PYTHONSTARTUP=~/.pythonrc.py
export PATH=$PATH:~/bin
export PAGER=less
export EDITOR=vim

# MacPorts Installer addition on 2020-12-07_at_11:56:46: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2020-12-07_at_11:56:46: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.

# Added by Toolbox App
export PATH="$PATH:/Users/emily/Library/Application Support/JetBrains/Toolbox/scripts"

# nix
export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH
