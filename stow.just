#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]

[private]
default:
    @just --list stow

[unix]
[doc("stow packages to $HOME")]
restow +FILES="*/":
    @stow --verbose --target="${HOME}" --restow {{FILES}}

[unix]
[doc("unstow packages from $HOME")]
delete +FILES="*/":
    @stow --verbose --target="${HOME}" --delete {{FILES}}
