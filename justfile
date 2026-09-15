#!/usr/bin/env just --justfile

[unix]
set shell := ["zsh", "-cu"]
[windows]
set shell := ["pwsh.exe", "-NoLogo", "-Command"]

# Module for stow recipes.
[group("modules")]
mod stow
# Module for git recipes.
[group("modules")]
mod git

[private]
default:
    @just --list

install: stow::install git::link-gitconfig

uninstall: stow::uninstall git::unlink-gitconfig
