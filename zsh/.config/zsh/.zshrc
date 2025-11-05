# .zshenv → .zprofile → [.zshrc] → .zlogin → .zlogout
# :: Configuration for interactive shells
# > ZSH settings
# > Sourcing of all ZSH modules
# > [Optional] profiling

# Profiling
# zmodload zsh/zprof

# History
export HISTFILE=$XDG_STATE_HOME/zsh/history
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
compinit -d $XDG_CACHE_HOME/zsh/compdump
## TODO: which parts of macOS can be sources?

# Sources
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/keybindings.zsh
##TODO: make these platform specific
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/colors.zsh
source $ZDOTDIR/direnv.zsh
source $ZDOTDIR/atuin.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/wsl.zsh
source $ZDOTDIR/just.zsh

# Profiling
# zprof
