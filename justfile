#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set shell := ["zsh", "-cu"]

# Module for GNU stow recipes.
mod stow
# Module for git recipes.
mod git
# Module for Windows specific recipes.
mod windows
# Module for macOS Dock.app recipes.
mod Dock "Dock.app"

[private]
default:
    @just --list

# Install UNIX configuration.
[unix]
install: stow::install git::link-gitconfig Dock::install

# Uninstall UNIX configuration.
[unix]
uninstall: stow::uninstall git::unlink-gitconfig Dock::uninstall

# Install Windows configuration.
[windows]
install: windows::install

# Uninstall Windows configuration.
[windows]
uninstall: windows::uninstall

# Update and initialize submodules.
[group("repo")]
update-submodules:
    @git submodule update --init

# Do a sparse checkout of each submodule.
[group("repo")]
sparse-checkout: update-submodules
    @git submodule foreach '$toplevel/sparse-checkout.sh'
