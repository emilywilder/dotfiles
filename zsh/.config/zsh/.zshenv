export XDG_CONFIG_HOME="$HOME/.config"
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