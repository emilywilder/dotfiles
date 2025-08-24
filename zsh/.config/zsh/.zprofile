# home bin
_path=(
    # home/bin
    ${HOME}/bin
)

# rust
_path+=("$HOME/.cargo/bin")

# macOS specific
if [[ "${OSTYPE}" =~ "darwin*" ]]; then
    _path+=(
        # MacPorts
        /opt/local/bin
        /opt/local/sbin
    )
    # for MacPorts Xorg
    export DISPLAY=:0
fi

path=(
    # user specific paths
    $_path
    # existing path
    $path
)

# export path for child processes
export PATH
