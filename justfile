#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

[private]
default:
    @just --list

[doc("stow packages to $HOME")]
install:
    @stow --verbose --target="${HOME}" --restow */

[doc("unstow packages from $HOME")]
uninstall:
    @stow --verbose --target="${HOME}" --delete */