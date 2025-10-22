#!/usr/bin/env just --justfile

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

[private]
default:
    @just --list

[doc("add packages to $HOME")]
stow:
    @stow --verbose --target="${HOME}" --restow */

[doc("remove packages from $HOME")]
unstow:
    @stow --verbose --target="${HOME}" --delete */