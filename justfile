#!/usr/bin/env just --justfile

set shell := ["zsh", "-cu"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

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
install: stow::install git::link-gitconfig

[windows]
install: git::link-gitconfig

[unix]
uninstall: stow::uninstall git::unlink-gitconfig

[windows]
uninstall: git::unlink-gitconfig
