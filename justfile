#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set shell := ["zsh", "-cu"]

# Module for GNU stow recipes.
[unix]
[group("modules")]
mod stow
# Module for git recipes.
[group("modules")]
mod git
# Module for Windows specific recipes.
[group("modules")]
mod windows

[private]
default:
    @just --list

# Install Linux configuration.
[linux]
install: unix-install

# Uninstall Linux configuration.
[linux]
uninstall: unix-uninstall

# Install macOS configuration.
[macos]
install: unix-install

# Uninstall macOS configuration.
[macos]
uninstall: unix-uninstall

# Install Windows configuration.
[windows]
install: windows::install

[private]
[unix]
unix-install: stow::install git::link-gitconfig

[private]
[unix]
unix-uninstall: stow::uninstall git::unlink-gitconfig
