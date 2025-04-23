# check for OS specific functions
case "${OSTYPE}" in
    darwin*)
        source $ZDOTDIR/functions.macos.zsh
    ;;
esac
# check that these programs exist before loading their functions
if which git >/dev/null; then
    source $ZDOTDIR/functions.git.zsh
fi
if which python >/dev/null; then
    source $ZDOTDIR/functions.python.zsh
fi
# check for machine specific functions
case "$(hostname -s)" in
    athena)
        source $ZDOTDIR/functions.athena.zsh
    ;;
esac