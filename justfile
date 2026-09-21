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

[unix]
install: git::install stow::install

[unix]
uninstall: stow::uninstall git::uninstall
