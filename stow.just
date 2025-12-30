#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]

[private]
default:
    @just --list stow

# Stow packages to $HOME.
[unix]
restow +FILES="*/":
    @stow --verbose --target="${HOME}" --restow {{FILES}}

# Unstow packages from $HOME.
[unix]
delete +FILES="*/":
    @stow --verbose --target="${HOME}" --delete {{FILES}}
