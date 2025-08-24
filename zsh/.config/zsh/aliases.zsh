if which eza >/dev/null; then
    alias ls='eza --icons --color-scale --color-scale-mode=gradient --hyperlink'
    alias ll='ls -l --git -M'
    alias lsd='ll -D'
else
    alias ls='ls --color'
    alias ll='ls -al'
    alias lsd='ll | grep ^d'
fi
alias paths='echo ${PATH//:/\\n}'
alias vi='vim'
alias diff='diff -u --color'
