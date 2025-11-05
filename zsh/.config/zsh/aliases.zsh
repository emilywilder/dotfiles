if which eza >/dev/null; then
    alias ls='eza --icons auto'
    alias ll='ls -l --git -M'
    alias lsd='ll -D'
    alias lsss='ll --sort=size --color-scale=size'
    alias lssd='ll --sort=date --color-scale=age'
else
    alias ls='ls --color'
    alias ll='ls -lh'
    alias lsd='ll -d */'
    alias lsss='ll -rS'
    alias lssd='ll -rt'
fi
alias paths='echo ${PATH//:/\\n}'
alias vi='vim'
alias diff='diff -u --color'
