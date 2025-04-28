alias ll='ls -al'
alias lsd='ll | grep ^d'
alias paths='echo ${PATH//:/\\n}'
alias vi='vim'
alias diff='diff -u --color'
alias gittree='git log \
    --graph \
    --full-history \
    --all \
    --color \
    --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'