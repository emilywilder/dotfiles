# History
HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=1000
SAVEHIST=1000

# Options
## don't cycle through options
setopt NO_AUTO_MENU
## allow parameter expansion, command substitution and arithmetic expansion
## before the prompt is evaluated
setopt PROMPT_SUBST
## commands to be appended to the history file, and new shells read history
setopt SHARE_HISTORY

# Completion
autoload compinit
compinit
## TODO: which parts of macOS can be sources?

# Sources
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/keybindings.zsh
##TODO: make these platform specific
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
