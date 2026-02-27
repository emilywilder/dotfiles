if which eza >/dev/null; then
    alias ls='eza --icons auto'
    alias l='ls -l --git -M -h'
    alias lsd='l -D'
    alias lss='l --sort=size --color-scale=size'
    alias lst='l --sort=date --color-scale=age'
else
    alias ls='ls --color'
    alias l='ls -lh'
    alias lsd='l -d */'
    alias lss='l -rS'
    alias lst='l -rt'
fi
alias paths='echo ${PATH//:/\\n}'
alias vi='vim'
alias diff='diff -u --color'
