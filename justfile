#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set shell := ["zsh", "-cu"]

mod stow
mod git
mod windows

[private]
default:
    @just --list

[unix]
install: stow::restow git::link-gitconfig

[unix]
uninstall: stow::delete git::unlink-gitconfig

[windows]
install: windows::install

[windows]
uninstall: windows::uninstall

[group("repo")]
update-submodules:
    @git submodule update --init

[group("repo")]
sparse-checkout: update-submodules
    @git submodule foreach '$toplevel/sparse-checkout.sh'
