#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# for [script] and which()
set unstable

# variables specific to windows, but just doesn't seem to allow for importing conditionally
import 'windows.env.just'

platform := if which('wslinfo') != "" { "wsl" } else { os() }
git_local_config := "local.config"

[private]
default:
    @just --list

[unix]
[group("stow")]
[doc("stow packages to $HOME")]
install +FILES="*/":
    @stow --verbose --target="${HOME}" --restow {{FILES}}

[unix]
[group("stow")]
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

[unix]
[group("git")]
[working-directory: "git/.config/git"]
unlink-gitconfig:
    rm {{git_local_config}}

[unix]
[group("git")]
[working-directory: "git/.config/git"]
link-gitconfig:
    ln -s {{platform}}.config {{git_local_config}}
