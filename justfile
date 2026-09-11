#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]

# Module for GNU stow recipes.
[unix]
[group("modules")]
mod stow
# Module for git recipes.
[group("modules")]
mod git

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

[private]
[unix]
unix-install: stow::install git::link-gitconfig

[private]
[unix]
unix-uninstall: stow::uninstall git::unlink-gitconfig
