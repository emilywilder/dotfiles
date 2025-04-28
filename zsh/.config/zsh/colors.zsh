export COLORTERM=truecolor
export CLICOLOR

# FreeBSD ls
# see https://man.freebsd.org/cgi/man.cgi?ls for details

# GNU ls
# see `dircolors -p` for information on format

# set and export LS_COLORS with dircolors if available
if which dircolors >/dev/null; then
    eval $(dircolors $ZDOTDIR/dircolors.256color)
fi
