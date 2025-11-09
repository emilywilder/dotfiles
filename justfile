#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set shell := ["zsh", "-cu"]

# variables specific to windows, but just doesn't seem to allow for importing conditionally
import 'windows.env.just'

[private]
default:
    @just --list

[unix]
[doc("stow packages to $HOME")]
install +FILES="*/":
    @stow --verbose --target="${HOME}" --restow {{FILES}}

[unix]
[doc("unstow packages from $HOME")]
uninstall +FILES="*/":
    @stow --verbose --target="${HOME}" --delete {{FILES}}

[windows]
[doc("Install PowerShell PROFILE")]
install:
    Copy-Item -Path {{POWERSHELL_CONFIG_PATH}} -Destination {{POWERSHELL_INSTALL_PATH}}

[windows]
[doc("Uninstall PowerShell PROFILE")]
uninstall:
    Remove-Item -Path {{POWERSHELL_INSTALL_PATH}}

update-submodules:
    @git submodule update --init

sparse-checkout: update-submodules
    @git submodule foreach '$toplevel/sparse-checkout.sh'
