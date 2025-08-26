export COLORTERM=truecolor
export CLICOLOR

# FreeBSD ls
# see https://man.freebsd.org/cgi/man.cgi?ls for details

# GNU ls
# see `dircolors -p` for information on format

# set and export LS_COLORS with dircolors if available
if which dircolors >/dev/null; then
    eval $(dircolors $ZDOTDIR/emily256.dircolors)
fi

# on macOS eza sets the config dir to ~/Library/Application Support/eza
# force to use XDG for all platforms
if which eza >/dev/null; then
    export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
fi