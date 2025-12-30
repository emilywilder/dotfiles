#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set shell := ["zsh", "-cu"]

# Module for GNU stow recipes.
mod stow
# Module for git recipes.
mod git
# Module for Windows specific recipes.
mod windows

[private]
default:
    @just --list

# Stow packages and link gitconfig.
[unix]
install: stow::restow git::link-gitconfig

# Unstow packages and unlink gitconfig.
[unix]
uninstall: stow::delete git::unlink-gitconfig

# Run windows install.
[windows]
install: windows::install

# Run windows uninstall.
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
