#!/usr/bin/env just --justfile

[unix]
set shell := ["zsh", "-cu"]
[windows]
set shell := ["pwsh.exe", "-NoLogo", "-Command"]

[unix]
set script-interpreter := ["zsh"]

# Module for GNU stow recipes.
[group("modules")]
mod stow
# Module for git recipes.
[group("modules")]
mod git

[private]
default:
    @just --list

install: git::install stow::install

uninstall: stow::uninstall git::uninstall
