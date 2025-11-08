# https://github.com/Aloxaf/fzf-tab
#if which fzf >/dev/null; then
#    source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
#    # preview directory's content with eza when completing cd
#    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --width=1 --color=always $realpath'
#fi

source $ZDOTDIR/plugins/zsh-functional/functional.plugin.zsh
