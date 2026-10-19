# .zshenv → [.zprofile] → .zshrc → .zlogin → .zlogout
# :: Configuration for login shells
# > path variables

# update $path to be unique ( array-tied-special -> array-tied-unique-special )
typeset -U path
# set $_path to be array-unique
typeset -aU _path

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
        # texlive
        /Library/TeX/texbin
        # JetBrains Toolbox
        ${HOME}/Library/Application\ Support/JetBrains/Toolbox/scripts/
    )
fi

path=(
    # user specific paths
    $_path
    # existing path
    $path
)

# export path for child processes
export PATH
