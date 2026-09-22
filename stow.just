#!/usr/bin/env just --justfile

set unstable
set lists
set dotenv-load := true
[unix]
set shell := ["zsh", "-cu"]
[windows]
set shell := ["pwsh.exe", "-NoLogo", "-Command"]

[unix]
set script-interpreter := ["zsh"]

staux := "./staux.ps1" + \
    if env('DEBUG', 'false') == "true" { ' -Debug' } else { '' }

[private]
default:
    @just --list stow

# Restow packages to $HOME.
[unix]
[group("stow")]
restow +PKGS="*/":
    @stow --verbose --target="${HOME}" --restow {{PKGS}}

# Restow packages to $HOME.
[windows]
[group("staux")]
restow +PKGS="*/":
    {{staux}} -Verbose -Target "${HOME}" -Restow {{PKGS}}

# Delete packages from $HOME.
[unix]
[group("stow")]
delete +PKGS="*/":
    @stow --verbose --target="${HOME}" --delete {{PKGS}}

# Delete packages from $HOME.
[windows]
[group("staux")]
delete +PKGS="*/":
    {{staux}} -Verbose -Target "${HOME}" -Delete {{PKGS}}

# Adopt and stow packages to $HOME.
[unix]
[group("stow")]
adopt +PKGS="*/":
    @stow --verbose --target="${HOME}" --adopt {{PKGS}}

# Check if any files exist that would cause stow to fail.
[unix]
[script]
check +PKGS="*/":
    for _d in {{PKGS}} ; do
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
    if test -e ${_file} -a ! -L ${_file} -a ! -L ${_file:h}; then
        print "Removing stale atuin config file: ${_file}"
        rm ${_file}
        print "Removing stale atuin config directory: ${_file:h}"
        rmdir ${_file:h}
    fi

# Run all fixes then stow all packages to $HOME.
[unix]
install: fixes restow

# Stow all packages to $HOME.
[windows]
install: restow

# Unstow all packages from $HOME.
uninstall: delete

[unix]
[private]
fixes: stale-atuin-config
