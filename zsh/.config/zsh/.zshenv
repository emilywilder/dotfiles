# XDG BDS: https://specifications.freedesktop.org/basedir-spec/latest/
# user-specific data files
export XDG_DATA_HOME="$HOME/.local/share"
# user-specific configuration files
export XDG_CONFIG_HOME="$HOME/.config"
# user-specific state files
# It may contain:
#   actions history (logs, history, recently used files, …)
#   current state of the application that can be reused on a restart
#       (view, layout, open files, undo history, …)
export XDG_STATE_HOME="$HOME/.local/state"

# zsh specific
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# less is more
export PAGER=less
export EDITOR=vim

# macOS Disable Resume Support: Save/Restore Shell State
if [[ "${OSTYPE}" =~ "darwin*" ]]; then
    export SHELL_SESSIONS_DISABLE=1
fi

# new files set to perms: u=rwx,g=rx,o=rx
umask 022