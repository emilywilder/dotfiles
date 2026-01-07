#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]
set script-interpreter := ["zsh"]

[private]
default:
    @just --list stow

# Restow packages to $HOME.
[unix]
[group("stow")]
restow +FILES="*/":
    @stow --verbose --target="${HOME}" --restow {{FILES}}

# Delete packages from $HOME.
[unix]
[group("stow")]
delete +FILES="*/":
    @stow --verbose --target="${HOME}" --delete {{FILES}}

# Adopt and stow packages to $HOME.
[unix]
[group("stow")]
adopt +FILES="*/":
    @stow --verbose --target="${HOME}" --adopt {{FILES}}

# Check if any files exist that would cause stow to fail.
[unix]
[script]
check +FILES="*/":
    for _d in {{FILES}} ; do
        # only look at stow packages
        if [ ! -f ${_d}/.stow-local-ignore ]; then
            _pkg="${_d:t}"
            print "checking ${_pkg}"
            # if chkstow finds any "aliens" then treat that as an error
            if \chkstow --target=${HOME}/.config/${_pkg} --aliens | grep ^; then
                return 1
            fi
        fi
    done

# The shell session used to uninstall the atuin package still has the shell
# initialization present, and commands given after uninstallation are recorded
# by atuin. This results in atuin writing a default config which causes stow
# to complain about an existing file.
#
# This can be circumvented by disabling the zsh autin pre{cmd,exec} hooks prior
# to running the just target:
#   add-zsh-hook -d precmd _atuin_precmd
#   add-zsh-hook -d preexec _atuin_preexec
# Source: https://github.com/atuinsh/atuin/issues/517#issuecomment-1271702597

ATUIN_CONFIG_TOML := join("$HOME", ".config/atuin/config.toml")

# Remove stale atuin config.toml.
[unix]
[group("fixes")]
[script]
stale-atuin-config:
    _file={{ATUIN_CONFIG_TOML}}
    # file exists and is not a symlink
    if test -e ${_file} -a ! -L ${_file}; then
        print "Removing stale atuin config: ${_file}"
        rm ${_file}
    fi

# Run all fixes then stow all packages to $HOME.
install: fixes restow

# Unstow all packages from $HOME.
uninstall: delete

[private]
fixes: stale-atuin-config
