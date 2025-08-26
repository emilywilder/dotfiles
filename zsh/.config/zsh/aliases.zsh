if which eza >/dev/null; then
    alias ls='eza --icons --hyperlink'
    alias ll='ls -l --git -M'
    alias lsd='ll -D'
    alias lss='ll --sort=size --color-scale'
else
    alias ls='ls --color'
    alias ll='ls -lh'
    alias lsd='ll -d */'
    alias lss='ll -Sr'
fi
alias paths='echo ${PATH//:/\\n}'
alias vi='vim'
alias diff='diff -u --color'
