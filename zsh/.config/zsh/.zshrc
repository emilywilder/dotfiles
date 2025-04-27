# History
HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=12000
SAVEHIST=10000

# Options
## don't cycle through options
setopt NO_AUTO_MENU
## allow parameter expansion, command substitution and arithmetic expansion
## before the prompt is evaluated
setopt PROMPT_SUBST
## commands to be appended to the history file, and new shells read history
setopt SHARE_HISTORY

# Completion
# invocation as per the INITIALIZATION section of the
# zshcompsys man page
autoload -U compinit
compinit
## TODO: which parts of macOS can be sources?

# FIXME: only works for linux. make portable
# set LS_COLORS
eval $(dircolors $ZDOTDIR/dircolors.256color)

# Sources
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/keybindings.zsh
##TODO: make these platform specific
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
