#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set shell := ["zsh", "-cu"]

# Module for GNU stow recipes.
[group("modules")]
mod stow
# Module for git recipes.
[group("modules")]
mod git
# Module for Windows specific recipes.
[group("modules")]
mod windows
# Module for macOS Dock.app recipes.
[group("modules")]
mod Dock "Dock.app"

[private]
default:
    @just --list

# Install Linux configuration.
[linux]
install: unix-install

# Uninstall Linux configuration.
[linux]
uninstall: unix-install

# Install macOS configuration.
[macos]
install: unix-install Dock::install

# Uninstall macOS configuration.
[macos]
uninstall: unix-uninstall Dock::uninstall

# Install Windows configuration.
[windows]
install: windows::install

# Uninstall Windows configuration.
[windows]
uninstall: windows::uninstall

[private]
unix-install: stow::install git::link-gitconfig

[private]
unix-uninstall: stow::uninstall git::unlink-gitconfig
