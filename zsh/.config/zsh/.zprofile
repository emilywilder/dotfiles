# set python startup file
export PYTHONSTARTUP=${XDG_CONFIG_HOME}/python/pythonrc.py

#TODO: make this platform specific
path=(
    # home/bin
    ${HOME}/bin
    # nix
    ${HOME}/.nix-profile/bin
    /nix/var/nix/profiles/default/bin
    # MacPorts
    /opt/local/bin
    /opt/local/sbin
    # existing path
    $path
    # JetBrains toolbox
    "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts" # JetBrains toolbox
)

# export path for child processes
export PATH

#TODO: make this depend on MacPorts being used
# for MacPorts Xorg
export DISPLAY=:0