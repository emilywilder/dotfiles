# check for OS specific functions
case "${OSTYPE}" in
    darwin*)
        source $ZDOTDIR/functions.macos.zsh
    ;;
esac
# check that these programs exist before loading their functions
for _prog in git python; do
    if which ${_prog} >/dev/null; then
        source $ZDOTDIR/functions.${_prog}.zsh
        echo "Locded functions.${_prog}"
    fi
done
# check for machine specific functions
case "$(hostname -s)" in
    athena)
        source $ZDOTDIR/functions.athena.zsh
    ;;
esac